#!/bin/bash

# Start NGiNX reverse proxy
/usr/sbin/nginx

# Clean-up old log file
rm -f /opt/mirthconnect/logs/mirth.log

# Replace derby with postgresql
sed -i 's/database = derby/database = postgres/' /usr/local/mirthconnect/conf/mirth.properties

if [ -n "$DATABASE_URL" ]; then
  proto=`echo $DATABASE_URL | grep '://' | sed -e 's,^\(.*://\).*,\1,g'`
  url=`echo $DATABASE_URL | sed -e "s,$proto,,g" | cut -d@ -f2`
  userpass=`echo $DATABASE_URL | sed -e "s,$proto,,g" | cut -d@ -f1`
  user=`echo $userpass | cut -d: -f1`
  pass=`echo $userpass | cut -d: -f2`

  sed -i "s,database.url = jdbc:derby:\${dir.appdata}/mirthdb;create=true,database.url = jdbc:$proto$url," /usr/local/mirthconnect/conf/mirth.properties
  sed -i "s/database.username =/database.username = $user/" /usr/local/mirthconnect/conf/mirth.properties
  sed -i "s/database.password =/database.password = $pass/" /usr/local/mirthconnect/conf/mirth.properties
else
  sed -i 's,database.url = jdbc:derby:${dir.appdata}/mirthdb;create=true,database.url = jdbc:postgresql://localhost:5432/mirthdb,' /usr/local/mirthconnect/conf/mirth.properties
fi

cat /usr/local/mirthconnect/conf/mirth.properties

# Start Mirth Connect
./mcservice start

# Make sure that the service has actually started
while [ ! -f /opt/mirthconnect/logs/mirth.log ]
do
  sleep 0.1
done

# Don't spin wait if the service is dead
./mcservice status
if [[ `./mcservice status` != "The daemon is running." ]]; then
    echo "The daemon is not running"
    exit 1
fi

while ! echo exit | nc localhost 443; do sleep 0.1; done

pids=$(pgrep java)
echo $pids

echo user changepw admin $MIRTH_ADMIN_PW > pw.txt
java -jar mirth-cli-launcher.jar -a https://localhost:443 -u admin -p admin -v 0.0.0 -s pw.txt

java -jar mirth-cli-launcher.jar -a https://localhost:443 -u admin -p $MIRTH_ADMIN_PW -v 0.0.0 -s mirthconnect-cli.txt

tail -f /opt/mirthconnect/logs/mirth.log --pid=$pids

service nginx stop
