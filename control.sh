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

cd $(dirname $0)
#general
if [ $# -eq 0 ] || [ "$1" = "start" ]; then
    echo "Server is starting..."
    if [ -f ${JAVA} ]; then
        if [ -f ${JARFILE} ]; then
            ./discordhook.sh start
            screen -UAmdS ${SCREEN_NAME} ${JAVA} -server -Xms${MEM} -Xmx${MEM} -jar ${JARFILE} nogui
        else
            echo "Server binary not found."
        fi
    else
        echo "Java not found."
    fi
elif [ "$1" = "stop" ]; then
    echo "Server will stop in '${WAIT} seconds'..."
    ./discordhook.sh stop
    screen -p 0 -S ${SCREEN_NAME} -X eval 'stuff "say '${WAIT}'秒後にサーバーを停止します\015"'
    sleep $WAIT
    screen -p 0 -S ${SCREEN_NAME} -X eval 'stuff "stop\015"'
    echo "Server stopped."
elif [ "$1" = "backup" ]; then
    echo "Backup"
    if [ -d ${SERVER_DIR} ] && [ -d ${BACKUP_DIR} ]; then
        DATE=$(date "+%Y-%m-%d_%H:%M:%S")
        cp -r ${SERVER_DIR} ${BACKUP_DIR}/${DATE}
    else
        echo "Directory not found."
    fi
#whitelist
elif [ "$1" = "whitelist-on" ]; then
    screen -p 0 -S ${SCREEN_NAME} -X eval 'stuff "whitelist on\015"'
elif [ "$1" = "whitelist-off" ]; then
    screen -p 0 -S ${SCREEN_NAME} -X eval 'stuff "whitelist off\015"'
elif [ "$1" = "whitelist-add" ] && [ $# -eq 2 ]; then
    screen -p 0 -S ${SCREEN_NAME} -X eval 'stuff "whitelist add '$2'\015"'
elif [ "$1" = "whitelist-remove" ] && [ $# -eq 2 ]; then
    screen -p 0 -S ${SCREEN_NAME} -X eval 'stuff "whitelist remove '$2'\015"'
elif [ "$1" = "whitelist-reload" ]; then
    screen -p 0 -S ${SCREEN_NAME} -X eval 'stuff "whitelist reload\015"'
#operator
elif [ "$1" = "op" ] && [ $# -eq 2 ]; then
    screen -p 0 -S ${SCREEN_NAME} -X eval 'stuff "op '$2'\015"'
elif [ "$1" = "deop" ] && [ $# -eq 2 ]; then
    screen -p 0 -S ${SCREEN_NAME} -X eval 'stuff "deop '$2'\015"'
#save
elif [ "$1" = "save-on" ]; then
    screen -p 0 -S ${SCREEN_NAME} -X eval 'stuff "save-on\015"'
elif [ "$1" = "save-off" ]; then
    screen -p 0 -S ${SCREEN_NAME} -X eval 'stuff "save-off\015"'
elif [ "$1" = "save-all" ]; then
    screen -p 0 -S ${SCREEN_NAME} -X eval 'stuff "save-all\015"'
#security
elif [ "$1" = "kick" ] && [ $# -eq 2 ]; then
    screen -p 0 -S ${SCREEN_NAME} -X eval 'stuff "kick '$2'\015"'
elif [ "$1" = "ban" ] && [ $# -eq 2 ]; then
    screen -p 0 -S ${SCREEN_NAME} -X eval 'stuff "ban '$2'\015"'
elif [ "$1" = "pardon" ] && [ $# -eq 2 ]; then
    screen -p 0 -S ${SCREEN_NAME} -X eval 'stuff "pardon '$2'\015"'
elif [ "$1" = "ban-ip" ] && [ $# -eq 2 ]; then
    screen -p 0 -S ${SCREEN_NAME} -X eval 'stuff "ban-ip '$2'\015"'
elif [ "$1" = "pardon-ip" ] && [ $# -eq 2 ]; then
    screen -p 0 -S ${SCREEN_NAME} -X eval 'stuff "pardon-ip '$2'\015"'
#download server.jar(1.19.2)
elif [ "$1" = "download" ]; then
    curl -OL https://piston-data.mojang.com/v1/objects/f69c284232d7c7580bd89a5a4931c3581eae1378/server.jar
#screen
elif [ "$1" = "attach" ]; then
    screen -r ${SCREEN_NAME}
fi
