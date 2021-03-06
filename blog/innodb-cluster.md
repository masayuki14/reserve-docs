# MySQLのイベントにいってきたはなし

[MySQL InnoDB Cluster入門　※大阪開催](https://atnd.org/events/95331?kme=clicked%2Bevent%2Bremind%2Bmail_url) に参加してきた。

最近はアプリケーションからDBとしてMySQLを使う程度で
インフラとしてのMySQLの利用から遠ざかっていたので
最近のMySQLの事情をキャッチアップするために参加してきた。

内容は MySQL InnoDB Cluster の概要と、構成方法、最後にデモを見せてくれた。
セミナーの資料も公開されている。 [セミナー資料](https://www.mysql.com/jp/why-mysql/presentations/mysql-innodb-cluster-201803/)

参加者が7名と少なかったけど、内容はかなり充実していた。MySQL使っている人は行ったほうがいいと思う。
今まで知らなかったけど結構セミナーをやっているようなので今後はフォローしていきたい。
主催者の[@yyamasaki1](https://atnd.org/users/129037?state=manage)さんがイベント管理をしている模様。

## MySQL InnoDB Cluster

- Mysql Group Replication
- MySQL Router
- Mysql Shell

の3つのコンポーネントを組み合わせて作るMySQLの高可用性構成。
それぞれは単体で利用できるコンポーネントで、これらを組み合わせることで自動フェイルオーバーを含む信頼性の高いDBインフラを構築できる。

# 今回知ったキーワード

## Mysql Group Replication

複数台のサーバーがグループを作って、お互いに通信しあいながらレプリケーションを行う。
グループのメンバー管理と障害検知が自動化されている。
マスタとなっているサーバーに障害が発生した時、自動的に他のサーバーが次のマスタが昇格する。
シングルマスターで運用できるけど、マルチマスタでの構成も容易。

## MySQL Router

複数のMySQLサーバーへの接続を振り分けてくれる。そのまんまルーター。
R/Oの複数台のサーバーを登録するとラウンドロビンで接続を振り分けてくれる。
負荷分散としても利用できる。
MySQL Group Replication と合わせて使う時、マスタサーバーが変わった時でも自動で追随してくれる。
アプリケーションはマスタがどのサーバーかを意識する必要がなくなる。

## Mysql Shell

MySQLサーバー管理用のCLIツール。Javascript、Python、SQLで管理コードが書ける。
MySQL Group Replicationで使う場合のサーバー設定を自動でうやってくれたり(my.confの設定など）
MySQL Routerの設定、管理もできる。
バッチ処理によるサーバー管理処理も自動化できちゃう。すごく良さそう。

## マルチスレッドスレーブ

スレーブ側のSQLスレッド（リレーログを実行してデータを更新するスレッド）がマルチスレッドになっている。
MySQL5.7から同一スキーマ、同一テーブルでもマルチスレッドで更新できるようになっていて、MySQL Group Replicationでもサポートしてる。

## スプリットブレイン

一般的なクラスタシステムで、それぞれのノードはうまく動いているのにお互いの通信だけがうまくいかない状態。
どちらも正常に更新できてしまうので、同期が復旧した時に競合が発生してしまう。
その回避のために、スプリットブレインが発生したらどちらかを落とすのが通常の解決策。
多数決で生存数の少ないグループに所属する方を落とす。その場合奇数の方がいい。
マルチマスタでMySQL InnoDB Clusterを構成する時に発生する。


# 次回のイベント

次回は5月25日に大阪で大きめのMySQLにイベントを企画しているようだ。
MySQLの開発者もアメリカからやって来てお弁当もついてくる大きめのイベントになるそう。
MySQL8のリリースは公式アナウンスはないけど、つまり、察するに・・・。


改めて認識したけど、どうも自分はDataBaseってやつがけっこう好きらしい。


---

InnoDB Cluster
3つのコンポーネントを組み合わせて作るフレームワーク

- MySQL Group Replication
- MySQL Router
- MySQL Shell

Architecture は3段階の構想で、Step1だけができている。
最小3台 => 最大9台

Enterprise 版の MySQL Enterprise Monitor にも専用の監視項目が用意されてる。

---

# MySQL Shell

管理用の CLI クライアント
InnoDB Cluster用のAPIが追加された。


---

グループレプリケーション
  - シングルプライマリモード
  - マルチマスタも可能

--read-only		: root 管理者なら更新できちゃう
--super-read-only !!	: root でも更新できない

グループレプリケーションにしておけば、障害が発生した時に自動で自動でマスタ昇格をやってくれちゃうYO！すごいね！

マルチマスタモードのとき
  - 更新確定のタイミング
  - 更新時に他のDBにサティフィケーションを事前に打って、過半数でOKだったらコミット確定するYO！
  - 更新処理の性能はオーバーヘッドが増えるぶん多少落ちる

GTIDをグループで同じものを共有する。
GTID - global transaction id

マルチスレッドスレーブ！！
--slave_parallel_workers=[NUMBER]
--slave_parallel_type=logical_clock
--slave_preserve_commit_order=ON

SSL接続ができまっせ。

IPv4のみ.

設定に必要なオプションうんぬんは mysqlShell で一括で設定して my.cnf に追記できるぜ！

スプリットブレインってなに？
  クラスタシステムで、それぞれはうまく動いているのにお互いの通信だけがうまくいかない状態。
  どちらも正常に更新できてしまう。同期が復旧した時に、競合が発生してしまう。
  発生したらどちらかを落とすのが通常の解決策。
  多数決で生存数の少ない方を落とす。その場合奇数の方がいい。

今日は「スプリットブレイン」を知っただけでも収穫だ！！

マルチマスタモード
  - auto increment もサポートしてて、デフォルトの増分は7


# 他の高可用性構成パターンとの比較

- アプリ接続先の自動フェイルオーバ
- DBの自動フェイルオーバ
- データロスなし


```

show variables like '%group%'

グループレプリケーション関連の設定項目
```


R/O の方のルーターはラウンドロビンでNodeを振り分けてくれる.


---


GTID のレプリケーションは、ポジションを指定する必要がない。
GTID の指定をしてやればOK.

途中からNodeを参加させるときは、バックアップをとってリストアしたものをグループに参加してやれば
GTIDから復旧できる。
障害が発生したNodeが復旧して参加できるイメージと同じ。

