#!/bin/bash

BOTNAME="MINECRAFT-SERVER"
SERVERNAME="SERVER1"
WEBHOOK_URL="" # DiscordのWebHookURLを記入

#general
if [ "${WEBHOOK_URL}" != "" ]; then
    if [ "$1" = "start" ]; then
        curl \
            -X POST \
            -H "Content-Type: application/json" \
            -d "{\"username\": \"${BOTNAME}\", \"content\": \"[$(date "+%Y/%m/%d %H:%M:%S")]\t${SERVERNAME}を起動します．\"}" \
            "${WEBHOOK_URL}"
    elif [ "$1" = "stop" ]; then
        curl \
            -X POST \
            -H "Content-Type: application/json" \
            -d "{\"username\": \"${BOTNAME}\", \"content\": \"[$(date "+%Y/%m/%d %H:%M:%S")]\t${SERVERNAME}を停止します．\"}" \
            "${WEBHOOK_URL}"
    fi
fi
