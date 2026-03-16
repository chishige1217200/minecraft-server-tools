起動設定
```sh
systemctl daemon-reload

systemctl enable --now minecraft-start.timer
systemctl enable --now minecraft-stop.timer
systemctl enable --now minecraft-backup.timer
```

確認
```sh
systemctl list-timers
```
