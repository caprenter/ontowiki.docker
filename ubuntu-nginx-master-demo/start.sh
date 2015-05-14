#!/bin/sh

echo "updating OntoWiki …"
cd /var/www
git fetch
git checkout master
git pull
make deploy

# start the virtuoso service
#echo "starting virtuoso …"
#service virtuoso-opensource-6.1 start
#From:https://github.com/AKSW/OntoWiki/wiki/VirtuosoBackend
cd /usr/local/var/lib/virtuoso/db/
virtuoso-t -f -c /opt/virtuoso/var/lib/virtuoso/ontowiki/virtuoso.ini
cd /var/www

# start the php5-fpm service
echo "starting php …"
service php5-fpm start

# start the nginx service
echo "starting nginx …"
service nginx start

echo "OntoWiki is ready to set sail!"
cat /ow-docker.fig
echo ""
echo "following log:"

OWLOG="/var/www/logs/ontowiki.log"
touch $OWLOG
chmod a+w $OWLOG
tail -f $OWLOG
