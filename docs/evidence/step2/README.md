# Step 2 証跡(ALB → EC2)

apply 後、以下のスクリーンショットをこのディレクトリに保存してから destroy する。

| ファイル名 | 内容 |
|-----------|------|
| `01-terraform-apply.png` | `terraform apply` 完了ログ(Apply complete と `alb_dns_name` の output が見える状態) |
| `02-browser-alb.png` | ブラウザで `http://<alb_dns_name>/` を開き「Step 2 OK」ページが表示された画面(URL バー含む) |
| `03-direct-ip-blocked.png` | `http://<web_public_ip>/` が接続タイムアウトになる画面(SG で直アクセスが遮断されている証跡) |
| `04-target-group-healthy.png` | マネジメントコンソールのターゲットグループで EC2 が `healthy` になっている画面 |
| `05-terraform-destroy.png` | `terraform destroy` 完了ログ(Destroy complete) |
