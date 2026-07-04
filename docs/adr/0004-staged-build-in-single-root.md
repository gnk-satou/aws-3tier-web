# ADR-0004: 単一の Terraform ルートで段階的に構築する

- Status: Accepted
- Date: 2026-07-03

## Context

Step 1(VPC+EC2)→ Step 2(ALB)→ Step 3(RDS+NAT)と段階構築する。
Step ごとにディレクトリを分ける案と、単一ルートを PR で育てる案がある。

## Decision

`terraform/` 単一ルート構成とし、各 Step は Issue → ブランチ → PR で差分として積み上げる。

## Consequences

- 各 Step の差分が PR 履歴としてそのまま残り、成長過程を示せる
- コード重複がなく、常に「最新の完成形」が main にある
- 過去 Step の状態はタグ(例: `step1`)と PR で参照できる
- モジュール分割は規模的に過剰なため今回は行わない(必要になれば新 ADR で判断)
