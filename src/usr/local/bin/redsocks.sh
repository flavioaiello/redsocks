#!/bin/bash

# set env vars to config
sed -i -e "s/\${HTTP_RELAY}/${HTTP_RELAY}/g" -e "s/\${TCP_RELAY}/${TCP_RELAY}/g" tmp/redsocks.conf

# SIGTERM-handler
term_handler() {
    if [ $pid -ne 0 ]; then
        echo "Term signal catched. Shutdown redsocks and disable iptables rules..."
        kill -SIGTERM "$pid"
        wait "$pid"
        iptables-save | grep -v REDSOCKS | iptables-restore
    fi
    exit 143; # 128 + 15 -- SIGTERM
}

# setup handler
trap 'kill ${!}; term_handler' SIGTERM

# Cleanup iptables
iptables-save | grep -v REDSOCKS | iptables-restore

# First we added a new chain called 'REDSOCKS' to the 'nat' table.
iptables -t nat -N REDSOCKS

# Set proxy exceptions for docker0 bridge
iptables -t nat -A REDSOCKS -d 172.17.0.0/16  -j RETURN
iptables -t nat -A REDSOCKS -d 10.1.0.0/16 -j RETURN
iptables -t nat -A REDSOCKS -d 10.189.0.0/16 -j RETURN
iptables -t nat -A REDSOCKS -d 127.0.0.0/24 -j RETURN

# We then told iptables to redirect all port 80 connections to the http-relay redsocks port and all other connections to the http-connect redsocks port.
iptables -t nat -A REDSOCKS -p tcp --dport 80 -j REDIRECT --to-ports 12345
iptables -t nat -A REDSOCKS -p tcp -j REDIRECT --to-ports 12346

# Finally we tell iptables to use the ‘REDSOCKS’ chain for all outgoing connection in the network interface ‘eth0′.
iptables -t nat -A PREROUTING -i docker0 -p tcp -j REDSOCKS

# Starting redsocks
echo "Starting redsocks..."
/usr/sbin/redsocks -c /tmp/redsocks.conf &
pid="$!"

# wait indefinetely
while true
do
  sleep 1 & wait ${!}
done
