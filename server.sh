#!/bin/bash

#JAVAバイナリのパスを指定.
JAVA=/home/minecraft/jdk-18.0.1.1/bin/java
#サーバとバックアップディレクトリの場所を指定. DIRの末尾に/は必要ありません.
SERVER_DIR=/home/minecraft/server
BACKUP_DIR=/home/minecraft/server_backup
#.jarファイルのパスを指定.
JARFILE=/home/minecraft/server/minecraft_server.jar
#screenでの識別名を指定
SCREEN_NAME='minecraft'
#サーバのメモリ割当を指定
MEM=4G
#サーバ終了時の猶予時間を指定
WAIT=30

if [ $# -eq 0 ] || [ "$1" = "start" ]; then
    echo "Server is starting..."
    cd $(dirname $0)
    screen -UAmdS ${SCREEN_NAME} ${JAVA} -server -Xms${MEM} -Xmx${MEM} -jar ${JARFILE} nogui
elif [ "$1" = "stop" ]; then
    echo "Server will stop in '${WAIT} seconds'..."
    screen -p 0 -S ${SCREEN_NAME} -X eval 'stuff "say '${WAIT}'秒後にサーバーを停止します\015"'
    sleep $WAIT
    screen -p 0 -S ${SCREEN_NAME} -X eval 'stuff "stop\015"'
    echo "Server stopped."
elif [ "$1" = "backup" ]; then
    echo "Backup"
    DATE=$(date "+%Y-%m-%d_%H:%M:%S")
    cp -r ${SERVER_DIR} ${BACKUP_DIR}/${DATE}
fi
