# minecraft-server-tools
サーバの起動・終了・バックアップを1つのshで管理します．screenを使用します．

## コマンド
| コマンド         | 引数   | 使い方                             |
| :--------------- | :----- | :--------------------------------- |
| start            |        | サーバを起動する                   |
| stop             |        | サーバを終了する                   |
| backup           |        | サーバをバックアップする           |
| whitelist-on     |        | ホワイトリストを有効化する         |
| whitelist-off    |        | ホワイトリストを無効化する         |
| whitelist-add    | [user] | ホワイトリストに[user]を追加する   |
| whitelist-remove | [user] | ホワイトリストから[user]を除外する |
| whitelist-reload |        | ホワイトリストを再読込する         |
| op               | [user] | 管理者に[user]を追加する           |
| deop             | [user] | 管理者から[user]を除外する         |
| save-on          |        | 自動セーブを有効化する             |
| save-off         |        | 自動セーブを無効化する             |
| save-all         |        | 現時点の状況をセーブする           |
| kick             | [user] | [user]をキックする                 |
| ban              | [user] | [user]をバンする                   |
| pardon           | [user] | [user]をバン解除する               |
| ban-ip           | [ip]   | [ip]をバンする                     |
| pardon-ip        | [ip]   | [ip]をバン解除する                 |
| download         |        | server.jar(1.19)をダウンロードする |
| attach           |        | screenに入る                       |