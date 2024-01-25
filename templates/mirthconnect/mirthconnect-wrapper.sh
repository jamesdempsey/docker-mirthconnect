#!/bin/bash

# Start NGiNX reverse proxy
/usr/sbin/nginx

# Clean-up old log file
rm -f /opt/mirthconnect/apps/logs/mirth.log

# Start Mirth Connect
/opt/mirthconnect/apps/mcservice start

# Make sure that the service has actually started
while [ ! -f /opt/mirthconnect/apps/logs/mirth.log ]
do
  sleep 0.1
done

# Don't spin wait if the service is dead
/opt/mirthconnect/apps/mcservice status
if [[ `/opt/mirthconnect/apps/mcservice status` != "mcservice is running." ]]; then
    echo "mcservice is not running."
    exit 1
fi

while ! echo exit | nc localhost 8443; do sleep 0.1; done

pids=$(pgrep java)
echo $pids

echo user changepw admin $MIRTH_ADMIN_PW > pw.txt
/opt/mirthconnect/apps/mccommand -s /usr/local/mirthconnect/pw.txt >/dev/null

/opt/mirthconnect/apps/mccommand -p $MIRTH_ADMIN_PW -s /usr/local/mirthconnect/mirthconnect-cli.txt

tail -f /opt/mirthconnect/apps/logs/mirth.log --pid=$pids

service nginx stop
