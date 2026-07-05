# Step 3 証跡(プライベートサブネット化 + RDS)

apply 後、以下のスクリーンショットをこのディレクトリに保存してから destroy する。

| ファイル名 | 内容 |
|-----------|------|
| `01-terraform-apply.png` | `terraform apply` 完了ログ(Apply complete と `rds_endpoint` / `nat_gateway_public_ip` の output が見える状態) |
| `02-browser-alb.png` | ブラウザで `http://<alb_dns_name>/` を開き「Step 3 OK」ページが表示された画面(EC2 はプライベートサブネット、ALB 経由のみで到達可能) |
| `03-console-network-app.png` | private-app ルートテーブルの「ルート」タブ(`0.0.0.0/0 → nat-xxxx` があり、アウトバウンドが NAT 経由である証跡) |
| `03-console-network-db.png` | private-db ルートテーブルの「ルート」タブ(`10.0.0.0/16 → local` のみで、インターネット経路が存在しない証跡) |
| `04-ssm-mysql.png` | SSM Session Manager 経由で EC2 から RDS に MySQL 接続し `SELECT VERSION();` が成功した画面(パスワードは Secrets Manager 管理、ADR 0007) |
| `05-terraform-destroy.png` | `terraform destroy` 完了ログ(Destroy complete) |
