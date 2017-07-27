# Mackerelをつかってみよう

author
:   morisaki

# Mackerelとは

{::tag name="x-large"}システム監視ツール{:/tag}

# システム監視の目的

システム（サービス）の正常な状態を保つこと

- サーバーリソース
- データベース
- ウェブサーバー

# システム監視の目的

サーバーリソース
:   - HDD
    - CPU
    - Memory

データベースの状態
:   - Slow Query
    - Query 数

# システム監視の目的

ウェブサーバーの状態
:   - レスポンスタイム
    - Status Code

# システム監視とは

1. 「正常な状態」を**監視項目**とその**正常な結果**で定義する

1. 「正常な状態」でなくなった時の対応方法を定義する

1. 「正常な状態」を継続的に確認する

1. 「正常な状態」でなくなった場合に復旧し、再発防止策を講じる。

# システム監視とは

Mackerelは

* 「正常な状態」を継続的に確認する
* 「正常な状態」でなくなった場合に知らせてくれる

をしてくれる

# Mackerelの特徴

- クラウド型
- システム監視 as a Service
- エージェント型
- 通知の多様性
    - メール
    - Webhook
    - Slack

# System Metrics

エージェントが収集・投稿するメトリック

# System Metrics

- Load Average
- CPU使用率
- Memory使用率
- DiskIO
- Interface
- FileSystem使用率

# System Metrics

Load Average
:   * 「1CPUにおける単位時間あたりの実行待ちとディスクI/O待ちのプロセスの数」
    * CPUコア1つでロードアベレージが1ならCPUが100％使用されている状態
    * 16コアでロードアベレージ16ならCPUが100％使用されている状態

# System Metrics

DiskIO
:   * Input/Output Per Second.
    * ディスクの読み書きに関する、IOPS（1秒あたりのI/Oアクセス数）の値
    * 1秒間で読み込み・書き込みができる回数

# System Metrics

Interface
:   * ネットワークの使用状況 (KB/sec)
    * tx: 送信, rx: 受信

[参考](http://blog.a-know.me/entry/2017/02/02/215641)

# グラフの例

![](graph-cpu.png "CPU"){:width='640'}

# グラフの例

![](graph-memory.png "Memory"){:width='640'}

# Custom Metric

任意の値を投稿できる
:   - エージェントから投稿(plugin)
    - APIで投稿

# Webサーバーを計測する

サービス独自の監視項目を定義し継続的に観測する
:   - アクセス数
    - HTTP STATUS CODE
    - レスポンスタイム

# アクセスログを解析する

- mackerel-plugin

- シェルスクリプト

# アクセスログを解析する

![](plugin.png)

# エージェントから投稿

![](agent.png){:relative_margin_top="30"}


# なぜシェルスクリプト

巨人の肩に乗る
:   - 豊富なコマンド
    - テキスト処理が得意
    - パイプとリダイレクト


# 工夫したところ1

**抽出は `gerp` と `sed` を組み合わせる**

```
# 正規表現で範囲指定
$ start="2017-06-28 15:01"
$   end="2017-06-28 15:02"

$ sed -ne "/${start}/,/${end}/p" access_log \
  > tmp_access_log
```
{: lang="sh" }

ファイル全体に走査が必要。遅い。

# 工夫したところ1

**抽出は `gerp` と `sed` を組み合わせる**

```
# grepで開始行と終了行を取得して指定
$ start=$( grep -nE "2017-06-28 15:01" access_log |\
           head -1 |\
           cut -d: -f1 )
$ end=$( grep -nE "2017-06-28 15:02" access_log |\
         head -1 |\
         cut -d: -f1 )
$ sec -ne "${start},${end}p" access_log > tmp_access_log
```
{: lang="sh" }

抽出範囲を行で指定。速い。

# 工夫したところ2

**`yaml` と `ruby` で環境変数を定義**

API_KEYなどの環境変数を設定ファイルとしてyamlで管理したい。

```
---
vars:
  api_key:      4kTCH2qMNZ8h3uevc
  output_style: agent
```
{: lang="yaml" }

# 工夫したところ2

**`yaml` と `ruby` で環境変数を定義**

```
$ ruby -r yaml -e \
  "YAML.load_file('config.yml')['vars'].each{ |k,v|
    puts sprintf('export %s=%s', k.upcase, v)
  }" |\
while read l do;
  eval $l
done
```
{: lang="ruby" }

パイプを通すとサブシェルになる。

# 工夫したところ2

**`yaml` と `ruby` で環境変数を定義**

```
eval $(
  ruby -r yaml -e "
    YAML.load_file('config.yml')['vars'] do |k,v|
      puts sprintf('export %s=%s', k.upcase, v)
    end"
)
```
{: lang="ruby" }


evalにコードを渡す。

# アクセス数

![](custom.access_count.png){:width='640' relative_margin_top="10"}


# ステータスコード

![](custom.status.png){:width='640' relative_margin_top="10"}

# レスポンスタイム

![](custom.response_time.png){:width='640' relative_margin_top="10"}


# おわり
