# Step 1 証跡(VPC + EC2 nginx + SSM)

apply 後、以下のスクリーンショットをこのディレクトリに保存してから destroy する。

| ファイル名 | 内容 |
|-----------|------|
| `01-terraform-apply.png` | `terraform apply` 完了ログ(Outputs が見える状態) |
| `02-browser-nginx.png` | ブラウザで `http://<web_public_ip>/` を開き「Step 1 OK」ページが表示された画面(URL バー含む) |
| `03-ssm-session.png` | `aws ssm start-session --target <instance-id>` で接続したターミナル |
| `04-console-vpc.png` | マネジメントコンソールの VPC リソースマップ(サブネット・ルートテーブルが見える状態) |
| `05-terraform-destroy.png` | `terraform destroy` 完了ログ(Destroy complete) |
