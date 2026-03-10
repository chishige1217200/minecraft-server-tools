起動設定
```sh
systemctl daemon-reload

systemctl enable minecraft-start.timer
systemctl enable minecraft-stop.timer
systemctl enable minecraft-backup.timer
```

確認
```sh
systemctl list-timers
```
