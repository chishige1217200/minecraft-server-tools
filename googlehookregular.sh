#!/bin/bash

COMMON_KEY="" # POSTリクエスト用の鍵を記入
WEBHOOK_URL="" # GoogleのWebHookURLを記入

#general
if [ "${WEBHOOK_URL}" != "" ]; then
    # 定期実行またはメンテナンス終了時
    if [ $# -eq 0 ] || [ "$1" = "end" ]; then
        curl \
            -L -X POST \
            -sS -H 'Content-Type: application/json' \
            -d "{\"commonKey\":\"${COMMON_KEY}\", \"sys_status\": \"正常稼働中\"}" \
            "${WEBHOOK_URL}"
    # メンテナンス開始時
    elif [ "$1" = "start" ]; then
        curl \
            -L -X POST \
            -sS -H 'Content-Type: application/json' \
            -d "{\"commonKey\":\"${COMMON_KEY}\", \"sys_status\": \"メンテナンス中\"}" \
            "${WEBHOOK_URL}"
    fi
fi
