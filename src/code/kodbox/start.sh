#!/usr/bin/env bash
set +e

echo "start the sh"
if [ ! -d /mnt/nas/.kodbox-1.35.031/ ]; then
  wget http://images.devsapp.cn/application/kodbox/kodbox-1.35.031.zip -O /mnt/nas/kodbox-1.35.031.zip
  cd /mns/nas && unzip kodbox-1.35.031.zip && mv kodbox-1.35.031 .kodbox-1.35.031 && rm kodbox-1.35.031.zip && chmod -R 777 .kodbox-1.35.031
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