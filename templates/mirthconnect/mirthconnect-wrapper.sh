#!/bin/bash

./mcservice start
while ! echo exit | nc localhost 8443; do sleep 0.1; done
java -jar mirth-cli-launcher.jar -a https://localhost:8443 -u admin -p admin -v 0.0.0 -s mirthconnect-cli.txt
tail -f /usr/local/mirthconnect/logs/mirth.log
