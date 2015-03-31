#!/bin/bash

# Start NGiNX reverse proxy
/usr/sbin/nginx

# Start Mirth Connect
./mcservice start
while ! echo exit | nc localhost 443; do sleep 0.1; done
java -jar mirth-cli-launcher.jar -a https://localhost:443 -u admin -p admin -v 0.0.0 -s mirthconnect-cli.txt
tail -f /opt/mirthconnect/logs/mirth.log
