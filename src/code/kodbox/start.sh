#!/usr/bin/env bash
set +e

echo "start the sh"
if [ ! -d /mnt/nas/.kodbox-1.35.031 ]; then
  wget http://images.devsapp.cn/application/kodbox/kodbox-1.35.031.zip -O /code/kodbox-1.35.031.zip
  cd /code && unzip kodbox-1.35.031.zip && mv kodbox-1.35.031 .kodbox-1.35.031 && rm kodbox-1.35.031.zip && chown -R root:root  ./.kodbox-1.35.031 && mv ./.kodbox-1.35.031 /mnt/nas
fi


ln -s /mnt/nas/.kodbox-1.35.031 /wwwroot
mkdir -p /wwwroot/sessions

chown -R root:root /wwwroot

mkdir -p /tmp/log/nginx/
mkdir -p /tmp/var/nginx/
mkdir -p /tmp/var/sessions/

echo "start php-fpm"
php-fpm7.4 -R -c /code/php.ini -y /code/php-fpm.conf

echo "start nginx"
nginx -c /code/nginx.conf -g 'daemon off;'