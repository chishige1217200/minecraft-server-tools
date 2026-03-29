#!/bin/bash

# ----------------- 設定 -----------------
WEBHOOK_URL="" # DiscordのWebHookURLを記入
MENTION_USER_ID="" # メンションするユーザIDを記入

# ----------------- パラメータ -----------------
if [[ -z "$1" || -z "$2" ]]; then
  echo "Usage: $0 <description> <notify:true|false>" >&2
  exit 1
fi

DESCRIPTION=$1 # 文章
NOTIFY=$2 # メンション有無
HOSTNAME=$(hostname)

# 1. 条件分岐で変数を決定
if [[ $NOTIFY == true ]]; then
  CONTENT="<@${MENTION_USER_ID}>"
  TITLE="⚠️ ディスク使用率警告($HOSTNAME)"
  COLOR=16711680 # 0xff0000
else
  CONTENT=""
  TITLE="✅ ディスク使用率情報($HOSTNAME)"
  COLOR=65280 # 0x00ff00
fi

# 2. ペイロード作成
read -r -d '' PAYLOAD <<EOF
{
  "content": "$CONTENT",
  "allowed_mentions": { "parse": ["users"] },
  "embeds": [
    {
      "title": "$TITLE",
      "description": "${DESCRIPTION}",
      "color": $COLOR,
      "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
    }
  ]
}
EOF

# 3. POST 送信
curl -H "Content-Type: application/json" \
     -d "$PAYLOAD" \
     "$WEBHOOK_URL"
