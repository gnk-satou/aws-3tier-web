# ADR-0006: NAT Gateway は単一 AZ 構成にする

- Status: Accepted
- Date: 2026-07-05

## Context

Step 3 で EC2 をプライベートサブネットへ移すため、アウトバウンド通信
(dnf update / SSM / Secrets Manager)に NAT Gateway が必要になる。
本番のベストプラクティスは AZ ごとに NAT を配置する構成(AZ 障害時も
アウトバウンド継続)だが、NAT は 1 台あたり約 $45/月 + データ処理料が発生する。

## Decision

NAT Gateway は `public[0]`(ap-northeast-1a)に 1 台のみ配置し、
プライベート app サブネット 2 AZ 分のルートを共有する。

## Consequences

- コストが半減する。学習用途で apply → destroy 運用のため、AZ 障害耐性の低下は許容
- 1a の AZ 障害時、1c 側のアウトバウンドも停止する(本番では AZ ごとに NAT を配置すべき点を README に明記)
- DB サブネットには NAT ルートを与えず、インターネット経路を完全に遮断する
