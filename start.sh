#!/bin/bash
echo "Updating..."
cd /app
apt-get update && apt-get -y upgrade
php composer.phar -q self-update
php composer.phar -q install
git pull > /dev/null 2>&1
sed -i -e "s#local_path.*#local_path      = /downloads#g" /app/.env
#sed -i -e "s#email .*#email           ${EMAIL}#g" /app/config.ini
#sed -i -e "s#password.*#password        ${PASSWORD}#g" /app/config.ini
sed -i -e 's/^email*= email/email = '"$EMAIL"'/g' /app/.env
sed -i -e 's/^password*= password/password = '"$PASSWORD"'/g' /app/.env
cat /app/.env
#exec php /app/start.php
