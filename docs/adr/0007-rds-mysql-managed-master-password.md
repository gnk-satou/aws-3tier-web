# ADR-0007: RDS は MySQL 8.0、マスターパスワードは Secrets Manager 管理にする

- Status: Accepted
- Date: 2026-07-05

## Context

Step 3 で DB 層(RDS)を追加する。決めるべき点は 2 つ。

1. エンジン: 特定のアプリ要件はなく、一般的な 3 層 Web 構成として通用するものを選ぶ
2. マスターパスワードの扱い: `password` 引数に直書きすると tfstate と
   コード履歴に平文が残る。`random_password` + SSM SecureString 案もあるが、
   tfstate には依然として平文が残る

## Decision

- エンジンは MySQL 8.0(`db.t4g.micro`, gp3 20GB, 暗号化, シングル AZ)
- `manage_master_user_password = true` を使い、パスワードの生成・保管を
  RDS + Secrets Manager に委譲する(RDS 管理シークレットは追加料金なし)

## Consequences

- パスワードが Terraform コード・tfstate のどちらにも平文で残らない
- 検証時は `aws secretsmanager get-secret-value` で取得して mysql クライアントに渡す
- ローテーションは Secrets Manager 側で有効化可能(本プロジェクトでは未使用)
- シングル AZ / `skip_final_snapshot = true` は apply → destroy 運用のための割り切り(ADR-0003)
