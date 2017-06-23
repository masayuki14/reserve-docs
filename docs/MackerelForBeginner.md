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

エージェント(mackrel-agent) が収集・投稿するメトリック

- Load Average
- CPU使用率
- Memory使用率
- DiskIO
- Interface
- FileSystem使用率

## ちょっと解説

- Load Average
    * 「1CPUにおける単位時間あたりの実行待ちとディスクI/O待ちのプロセスの数」
    * CPUコア1つでロードアベレージが1ならCPUが100％使用されている状態
    * 16コアでロードアベレージ16ならCPUが100％使用されている状態
- DiskIO
    * Input/Output Per Second.
    * ディスクの読み書きに関する、IOPS（1秒あたりのI/Oアクセス数）の値
    * 1秒間で読み込み・書き込みができる回数
- Interface
    * ネットワークの使用状況 (KB/sec)
    * tx: 送信, rx: 受信

[参考](http://blog.a-know.me/entry/2017/02/02/215641)

## グラフの例

CPU

Memory

# Custom Metric

任意の値（カスタムメトリック）を定期的にエージェントから投稿できる

# Webサーバーを計測する

サービス独自の監視項目を定義し継続的に観測する

- アクセス数
- HTTP STATUS CODE
- レスポンスタイム

# アクセスログを解析する

apacheのアクセスログを解析しデータを算出

エージェント経由でデータを投稿

# シェルでテキスト処理


# アクセス数

# ステータスコード

# レスポンスタイム


https://www.slideshare.net/stanaka/140929mackerel
