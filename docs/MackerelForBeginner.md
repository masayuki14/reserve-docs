# Mackerelをつかってみよう

# システム監視の目的

システム（サービス）の正常な状態を保つこと。

- サーバーリソースの状態
    - HDD
    - CPU
    - Memory
- データベースの状態
    - Slow Query
    - Query 数
- ウェブサーバーの状態
    - レスポンスタイム
    - Status Code

# システム監視とは

1. 「正常な状態」を**監視項目**とその**正常な結果**で定義する
1. 「正常な状態」でなくなった時の対応方法を定義する
1. 「正常な状態」を継続的に確認する
1. 「正常な状態」でなくなった場合に復旧し、再発防止策を講じる。

# システム監視とは

Mackerelは
- 「正常な状態」を継続的に確認する
- 「正常な状態」でなくなった場合に知らせてくれる

# Mackerelの特徴

- クラウド型のサーバー監視ツール
- 監視対象のサーバーでエージェントが動作しMackerelにデータを送信する
- サーバー監視 as a Service
- 通知の多様性、メール、Webhook、Slack

# System Metrics

- Load Avarage
    「1CPUにおける単位時間あたりの実行待ちとディスクI/O待ちのプロセスの数」
- CPU使用率
- Memory使用率
- DiskIO
    read/write 回数
- Interface
- FileSystem

# 例

CPU

Memory

# Webサーバーを計測する

独自の監視項目を定義し継続的に観測する

# カスタムメトリック

- HTTP STATUS CODE
- 


# アクセスログを解析する

# シェルでテキスト処理

# アクセス数

# ステータスコード

# レスポンスタイム


https://www.slideshare.net/stanaka/140929mackerel
