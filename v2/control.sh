#!/bin/bash

#本スクリプトはコンテナでの実行を前提としているため、
#環境変数でJAVAのパス指定を行ってください。

#tmuxでの識別名を指定
SESSION="mcserver"
#サーバとバックアップディレクトリの場所を指定します。DIRの末尾に/は必要ありません。
SERVER_DIR="/opt/minecraft"
BACKUP_DIR="/opt/minecraft/backups"
#.jarファイルの名前を指定します。
JARFILE="server.jar"
#サーバのメモリ割当を指定します。
MEM=4G
#サーバ終了時の猶予時間を指定します。
WAIT=30

DATE=$(date +"%Y%m%d-%H%M%S")

cd $SERVER_DIR

start() {
    if tmux has-session -t $SESSION 2>/dev/null; then
        echo "サーバは既に起動しています。"
        exit 1
    fi

    if [ ! -f "$JARFILE" ]; then
        echo "サーバJARファイルが見つかりません: $JARFILE"
        exit 1
    fi

    tmux new-session -d -s $SESSION "java -server -Xms$MEM -Xmx$MEM -jar $JARFILE nogui"
}

stop() {
    if ! tmux has-session -t $SESSION 2>/dev/null; then
        echo "サーバが起動していません。"
        exit 1
    fi

    tmux send-keys -t $SESSION 'say '$WAIT'秒後にサーバーを停止します。' Enter
    sleep $WAIT
    tmux send-keys -t $SESSION "stop" Enter
}

attach() {
    tmux attach -t $SESSION
}

backup() {
    mkdir -p $BACKUP_DIR

    if tmux has-session -t $SESSION 2>/dev/null; then
        tmux send-keys -t $SESSION 'say バックアップを開始します' Enter
        tmux send-keys -t $SESSION "save-off" Enter
        tmux send-keys -t $SESSION "save-all" Enter
        sleep 5
    fi

    tar -czf $BACKUP_DIR/minecraft-$DATE.tar.gz \
        world world_nether world_the_end 2>/dev/null

    if tmux has-session -t $SESSION 2>/dev/null; then
        tmux send-keys -t $SESSION "save-on" Enter
        tmux send-keys -t $SESSION "say バックアップが完了しました" Enter
    fi

    # 世代管理 (7日)
    # find $BACKUP_DIR -type f -mtime +7 -delete
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
backup)
    backup
    ;;
*)
    echo "Usage: $0 {start|stop|attach|backup}"
    exit 1
esac
