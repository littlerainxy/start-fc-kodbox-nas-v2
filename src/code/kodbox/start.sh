#!/usr/bin/env bash
set +e

echo "start the sh"
mkdir -p /wwwroot
if [ ! -f /wwwroot/index.php ]; then
  wget http://images.devsapp.cn/application/kodbox/kodbox-1.35.031.zip -O /wwwroot/kodbox-1.35.031.zip
  cd /wwwroot && unzip kodbox-1.35.031.zip -d /wwwroot && cp -r /wwwroot/kodbox-1.35.031/* /wwwroot/ && rm -r ./kodbox-1.35.031
fi
mkdir -p /wwwroot/sessions

chmod -R 755 /wwwroot

mkdir -p /tmp/log/nginx/
mkdir -p /tmp/var/nginx/
mkdir -p /tmp/var/sessions/

echo "start php-fpm"
php-fpm7.4 -R -c /code/php.ini -y /code/php-fpm.conf

echo "start nginx"
nginx -c /code/nginx.conf -g 'daemon off;'