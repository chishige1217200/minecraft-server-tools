#!/bin/bash

# ----------------- 設定 -----------------
VOLUME='/dev/mapper/pve-root'
THRESHOLD=75

# ----------------- パラメータ -----------------
HOSTNAME=$(hostname)

echo "$VOLUME のディスク使用率を取得します"

# 1. df が実行できるか確認
if ! df -h "$VOLUME" > /dev/null 2>&1; then
    echo "❌ df コマンドが失敗しました" >&2
    exit 1
fi

# 2. 使用率を取得（% を除く）
USAGE=$(df -h "$VOLUME" | awk 'NR==2{gsub(/%/, "", $5); print $5}')

# 3. 空文字チェック
if [ -z "$USAGE" ]; then
    echo "⚠️ ディスク使用率が取得できません" >&2
    exit 1
fi

# 4. 数値チェック
if ! [[ "$USAGE" =~ ^[0-9]+$ ]]; then
    echo "⚠️ 取得した値が数値ではありません: $USAGE" >&2
    exit 1
fi

# 5. 使用率を数値として比較
if [ "$USAGE" -ge $THRESHOLD ]; then
  # 閾値以上の場合
  echo "⚠️ 使用率が高すぎます: ${USAGE}%"
  # Discord WebHook を使用して通知
  cd "$(dirname "$0")"
  ./notifydiskusage.sh "⚠️ 使用率が高すぎます: ${USAGE}%" true
else
  # 閾値未満の場合
  echo "✅️ 使用率は正常範囲内です: ${USAGE}%"
  # Discord WebHook を使用して通知
  cd "$(dirname "$0")"
  ./notifydiskusage.sh "✅️ 使用率は正常範囲内です: ${USAGE}%" false
fi
