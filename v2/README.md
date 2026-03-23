# minecraft-server-tools v2
サーバの起動・終了・バックアップをsystemdで自動化します．
Debian/Ubuntuを対象システムとしています。

## Requirements
下記のコマンドが使用できること。
- bash
- java(パスが通っていること)
- systemd
- tmux

下記のディレクトリにminecraftユーザのRW権限があること。
- /opt/minecraft
- /var/backups/minecraft
