# ADR-0002: EC2 への接続は SSH ではなく SSM Session Manager を使う

- Status: Accepted
- Date: 2026-07-03

## Context

EC2 への運用アクセス手段が必要。従来は SSH(鍵ペア + ポート 22 開放)が一般的だが、
鍵の管理・漏洩リスク・SG での 22 番開放が発生する。

## Decision

SSM Session Manager のみを接続手段とする。

- EC2 に `AmazonSSMManagedInstanceCore` を付与した IAM ロールをアタッチ
- 鍵ペアは作成せず、SG でポート 22 は開放しない
- 接続は `aws ssm start-session --target <instance-id>`

## Consequences

- 攻撃面が縮小(22 番閉鎖・鍵管理不要)、接続履歴が CloudTrail に残る
- Step 3 で EC2 をプライベートサブネットへ移す際も、NAT 経由の SSM エンドポイント通信でそのまま接続可能
- SSM Agent と IAM ロールが前提になる(AL2023 は Agent 同梱)
