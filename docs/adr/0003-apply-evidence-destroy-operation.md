# ADR-0003: apply → 証跡取得 → destroy の運用でコストを抑える

- Status: Accepted
- Date: 2026-07-03

## Context

最終構成(ALB + NAT Gateway + RDS)を常時稼働させると月約 $80 かかる。
学習・ポートフォリオ目的では常時稼働の必要はないが、「動いた証拠」は残したい。

## Decision

各 Step の完了時に以下を行う運用とする。

1. `terraform apply` で構築
2. 動作確認し、スクリーンショットを `docs/evidence/step<N>/` に保存
3. `terraform destroy` で全リソースを破棄

取得すべきスクリーンショットは各 Step の `docs/evidence/step<N>/README.md` に定義する。

## Consequences

- 月額コストをほぼゼロに抑えられる($10 の Budgets アラートも設定済み)
- 動作証跡がリポジトリに残り、稼働していなくても成果を示せる
- 再現性が Terraform コードで担保されるため、破棄しても失うものがない
- Elastic IP を使わないため IP は毎回変わる(証跡はスクショで担保)
