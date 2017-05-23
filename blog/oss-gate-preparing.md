# OSSGateWorkshop を開催するためにやったこと

先日OSSGateWorkshop を懇意にしているスプーキーズという企業で社内向けに開催しました。
この記事では開催にあたり行った準備や参考にした情報などをまとめています。
OSSGateWorkshopに参加した人が、これから同じように社内向けに開催したり、
運営のメンバーになって進行役をやったりする時に役に立つと幸いです。

開催の様子については企業のオフィシャルブログを御覧ください。
http://labs.spookies.co.jp/entry/2017/05/22/180434


## 筆者とOSSGateとの関わり

私は[OssGateWorkshopw@大坂(2017-02-25)](https://oss-gate.doorkeeper.jp/events/58579)にビギナーとして参加しました。
WorkshopでIssueを起票しOSS開発者の仲間入りをし、その後も継続してIssueの起票やPullRequestを行っています。
体験としてとても有意義なものとなったので、それをスプーキーズの勉強会にて発表しました。
ドキュメントをちょっと良くした程度のただのOSSの開発経験者です。
また、継続して交流を持つために[Gitter](https://gitter.im/oss-gate/home/)に参加しています。

## 開催の日程

通常のWorkshopは5〜6時間のスケジュールで構成されています。
今回は社内向けの開催ということで就業後に自由参加で行っています。
そのためそれだけの時間を確保するのは難しいので2回に分けて開催しました。

1日目では対象OSSを動かしてミニふりかえりを行ない、2日目ではそのOSSに対しフィードバックを行ないました。
タイムテーブルは以下のように構成しています。両日とも150分での構成です。

**1日目**

時刻 | やること
-:|:-
19:00 | スタート
19:10 | OSSGateの紹介
19:20 | アイスブレイク
19:35 | OSS開発手順を説明
20:00 | 対象OSSを動かす
21:00 | ミニふりかえり
21:30 | 終了

**2日目**


時刻 | やること
-:|:-
19:00 | 開始。おさらい
19:10 | プロジェクトにフィードバックする
20:40 | まとめ
20:50 | アンケート記入
21:00 | ワークショップのふりかえり
21:30 | 終了


## 進行するための準備

### OSSGateの目的を確認

OSSGateを冠して開催するには本家の目的を理解しそれに沿った形で実施する必要があります。
これについてはオフィシャルサイトに[OSS Gateへようこそ！](http://oss-gate.github.io/announce/update/2015/12/17/welcome-to-oss-gate.html)というページがあるので熟読しました。
また自身の「Workshop楽しかったな、同じ思いをする人が増えるといいな」という思いも蘇ります。

### 過去のレポートを確認

[Gitter](https://gitter.im/oss-gate/home/)で開催の旨を伝えたところこちらのレポートを紹介しもらいました。
http://oss-gate.github.io/report/workshop/2016/06/11/workshop-report.html
同じように社内向けの開催でのレポートでした。こちらに目を通すことで全体の流れを再確認することができます。

### 進行の動画を確認

開催するためには自分が進行役を務める必要があります。
これが一番大変な部分ですし、成否がかかっているところでもあります。
なのでここに一番労力を使いました。

幸い、YouTubeに[OssGateWorkshopw@大坂(2017-02-25)の動画](https://www.youtube.com/channel/UCko4k40eSvs_dchzcLCsJ4A)が公開されており、
こちらの進行を真似しました。
動画をしっかり見ることも大事ですが、原稿があったほうが安心なので話していることを文字に書き起こしました。
10分の動画を書き起こすのに約1時間かかりましたが、そのおかげで話す内容が頭に入った感じがします。

書き起こしたテキストは[こちら](https://github.com/masayuki14/workshop/tree/preparing_workshop/docs)にあります。

### 使用するリポジトリ

[本家のリポジトリ](https://github.com/oss-gate/workshop)をWorkshop参加時に[クローン](https://github.com/masayuki14/workshop)しているのでそれを使いました。
本家同様にIssueを起票するとデフォルトで入力されているので同じように使えます。
Workshopのふりかえりではアンケートを実施しますが、その結果を本家のリポジトリに[PullRequest](https://github.com/oss-gate/workshop/pull/410)することを想定していたので、それ用のブランチを用意しました。

### 使用するスライド

OSSGateWorkshopで使用するスライドは公開されておりいくつかの方法で利用できます。

- [rabbit Slide Show](https://slide.rabbit-shocker.org/authors/oss-gate/introduction-japanese/)
- [gem](https://rubygems.org/profiles/oss-gate)

実際の進行はGemのスライドで行ないました。[こちら](https://github.com/masayuki14/workshop/issues/1#issuecomment-300375331)のようなGemfileを用意してインストールして使用しました。
状況に合わせて[rabbit Slide Show](https://slide.rabbit-shocker.org/authors/oss-gate/introduction-japanese/)のスライドも使用しています。

### 読んでおけばよかったもの

本家のリポジトリで用意されている[シナリオ](https://github.com/oss-gate/workshop/blob/master/tutorial/scenario.md)には開催・進行するためのいろいろな情報がまとめられています。
これを見落としていたのはもったいないことでした。



