#!/bin/bash

BOTNAME="MINECRAFT-SERVER"
WEBHOOK_URL="" # DiscordのWebHookURLを記入
L_IP=`hostname  -I | awk -F" " '{print $1}'`
G_IP=`curl inet-ip.info`

# IPアドレスの通知
if [ "${WEBHOOK_URL}" != "" ]; then
        curl \
            -X POST \
            -H "Content-Type: application/json" \
            -d "{\"username\": \"${BOTNAME}\", \"content\": \"[$(date "+%Y/%m/%d %H:%M:%S")] -- IPアドレス通知 --\n　ローカルIPアドレスは  ${L_IP}  ，\nグローバルIPアドレスは  ${G_IP} です．\"}" \
            "${WEBHOOK_URL}"
fi
