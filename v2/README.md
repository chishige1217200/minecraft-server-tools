# minecraft-server-tools v2
サーバの起動・終了・バックアップをsystemdで自動化します．
Debian/Ubuntuを対象システムとしています。

Proxmoxコンテナを前提としているため、バックアップ機能はスクリプト内にありません。

## Requirements
下記の機能が使用できること。
- bash
- java(パスが通っていること)
- systemd
- tmux

## How to use
1. `/opt/minecraft`に`control.sh`と`server.jar`を配置する。
2. 初めてサーバを起動する場合は一度`control.sh start`を実行し、`eula.txt`を生成してその中身を`true`に変更する。
3. `/etc/systemd/system`に`minecraft.service`を配置する。
4. `systemctl enable minecraft.service`を実行して、OS起動時にサーバプロセスを起動するように設定する。
5. `systemctl start minecraft.service`を実行して、サーバプロセスを起動する。

意図的にサーバプロセスを終了したい場合は、`systemctl stop minecraft.service`で終了できます。

OS終了時に自動でサーバプロセスが終了されます。  
サーバプロセス終了時の待機時間をデフォルトで30秒に設定しているため、OS終了には30秒以上かかります。  
待機時間は`control.sh`内の`WAIT`で変更できます。
