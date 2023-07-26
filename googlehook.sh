#!/bin/bash

ID="1" # 更新対象のサーバIDを指定
COMMON_KEY="" # POSTリクエスト用の鍵を記入
WEBHOOK_URL="" # GoogleのWebHookURLを記入

#general
if [ "${WEBHOOK_URL}" != "" ]; then
    if [ "$1" = "start" ]; then
        curl \
            -L -X POST \
            -sS -H 'Content-Type: application/json' \
            -d "{\"commonKey\":\"${COMMON_KEY}\", \"id\":\"${ID}\", \"status\": \"ONLINE\", \"sys_status\": \"正常稼働中\"}" \
            "${WEBHOOK_URL}"
    elif [ "$1" = "stop" ]; then
        curl \
            -L -X POST \
            -sS -H 'Content-Type: application/json' \
            -d "{\"commonKey\":\"${COMMON_KEY}\", \"id\":\"${ID}\", \"status\": \"OFFLINE\", \"sys_status\": \"正常稼働中\"}" \
            "${WEBHOOK_URL}"
    fi
fi
