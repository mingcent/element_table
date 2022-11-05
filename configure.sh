#!/bin/sh

config_path=$PROTOCOL"_ws_tls.json"

envsubst '\$UUID,\$WS_PATH' < $config_path > /my_config.json
# MK TEST FILES
mkdir /opt/test
cd /opt/test
dd if=/dev/zero of=100mb.bin bs=100M count=1
dd if=/dev/zero of=10mb.bin bs=10M count=1

chmod +x /monitor

/monitor -config /my_config.json &
# Run nginx
/bin/bash -c "envsubst '\$PORT,\$WS_PATH' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf" && nginx -g 'daemon off;'