#!/bin/bash
echo "Updating..."
cd /app
apk -q update
apk -q upgrade
composer -q self-update
composer -q install
git pull > /dev/null 2>&1
sed -i -e "s#local_path.*#local_path      = /downloads#g" /app/config.ini
#sed -i -e "s#email .*#email           ${EMAIL}#g" /app/config.ini
#sed -i -e "s#password.*#password        ${PASSWORD}#g" /app/config.ini
sed -i -e 's/^email*= email/email = '"$EMAIL"'/g' /app/config.ini
sed -i -e 's/^password*= password/password = '"$PASSWORD"'/g' /app/config.ini
cat /app/config.ini
#exec php /app/start.php
