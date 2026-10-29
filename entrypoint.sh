#!/bin/sh
set -e

: "${PORT:=8080}"
: "${WS_PATH:=/vless-ws}"

if [ -z "$UUID" ]; then
  echo "错误: 请在 Railway 环境变量里设置 UUID" >&2
  exit 1
fi

sed -e "s|__PORT__|${PORT}|g" \
    -e "s|__UUID__|${UUID}|g" \
    -e "s|__WS_PATH__|${WS_PATH}|g" \
    /etc/xray/config.template.json > /etc/xray/config.json

exec /usr/local/bin/xray run -c /etc/xray/config.json
