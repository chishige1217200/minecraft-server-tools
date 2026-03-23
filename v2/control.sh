#!/bin/bash

#本スクリプトはコンテナでの実行を前提としているため、
#環境変数でJAVAのパス指定を行ってください。

#tmuxでの識別名を指定
SESSION="mcserver"
#サーバの場所を指定します。DIRの末尾に/は必要ありません。
SERVER_DIR="/opt/minecraft"
#.jarファイルの名前を指定します。
JARFILE="server.jar"
#サーバのメモリ割当を指定します。
MEM=4G
#サーバ終了時の猶予時間を指定します(60秒以上にする場合はserviceファイルも変更が必要)。
WAIT=30

cd $SERVER_DIR

start() {
    if tmux has-session -t $SESSION 2>/dev/null; then
        echo "サーバは既に起動しています。"
        exit 1
    fi

    if [ ! -f "$JARFILE" ]; then
        echo "サーバJARファイルが見つかりません: $SERVER_DIR/$JARFILE"
        exit 1
    fi

    tmux new-session -d -s $SESSION "java -server -Xms$MEM -Xmx$MEM -jar $JARFILE nogui"
    echo "サーバを起動しました。"
}

stop() {
    if ! tmux has-session -t $SESSION 2>/dev/null; then
        echo "サーバが起動していません。"
        exit 1
    fi

    tmux send-keys -t $SESSION 'say '$WAIT'秒後にサーバーを停止します。' Enter
    sleep $WAIT
    tmux send-keys -t $SESSION "stop" Enter

    echo "サーバ停止待機中..."
    while tmux has-session -t $SESSION 2>/dev/null; do
        sleep 1
    done
    echo "サーバを停止しました。"
}

attach() {
    tmux attach -t $SESSION
}

case "$1" in
start)
    start
    ;;
stop)
    stop
    ;;
attach)
    attach
    ;;
*)
    echo "Usage: $0 {start|stop|attach}"
    exit 1
esac
