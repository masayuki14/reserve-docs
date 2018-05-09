# MySQL InnoDB Cluster を使って運用を手抜きしよう

author
:   @masayuki14

theme
:   blue-bar

# 自己紹介

森崎雅之 (@masayuki14)

コミュニティ
:    はんなりPython
     OSS Gate

仕事
:    主夫
     パートタイム エンジニア
     スプーキーズアンバサダー


# アジェンダ

1. Replication
2. MySQL InnoDB Cluster
3. MySQL Group Replication
4. MySQL Router
5. MySQL Shell
6. デモ


# Replicationとは

- データの複製を別サーバーにもたせる
- MySQLの標準機能
- Master -> Slave という構成


![](Master_Slave.png)

# Replication Topology

![](Topology.png)

![](Topology-tree.png)

# Replication 参照性能の向上

![](dispersion.png)

参照処理の不可が高い場合にはスレーブを増やし
負荷分散を行うことで参照性能を向上させる。


# MySQL InnoDB Clusterとは?

3つのコンポーネントを組み合わせて作るMySQLの高可用性構成。

- MySQL GroupReplication
- MySQL Router
- MySQL Shell


# MySQL InnoDB Cluster

特徴
:	- 簡易なセットアップ
	- 自動フェイルオーバー
	- マスタの自動昇格
	- M/Sの接続自動切り替え
	- 容易なスケールアップ

# MySQL InnoDB Cluster

![](MySQLInnoDBCluster.png)


# MySQL GroupReplication

- フェイルオーバーが自動化
- 構成の拡張・縮小が容易
- 単一障害点がない
- 自動再構成

MySQL 5.7.17 以降で利用可能

# MySQL GroupReplication

全ノードがマスターで等価の関係のグループを構成
MySQL側でのフェイルオーバー処理が不要

![](FailOver.png)

# MySQL GroupReplication

全ノードがマスターで等価の関係のグループを構成
MySQL側でのフェイルオーバー処理が不要

![](FailOverX.png)



## 説明

マスタとなっているサーバーに障害が発生した時、自動的に他のサーバーが次のマスタに昇格する。
複数台のサーバーがグループを作って、お互いに通信しあいながらレプリケーションを行う。
グループのメンバー管理と障害検知が自動化されている。
シングルマスターで運用できるけど、マルチマスタでの構成も容易。

# MySQL Router

複数のMySQLサーバーへの接続を振り分けてくれる。
そのまんまルーター。
R/Oの複数台のサーバーを登録するとラウンドロビンで接続を振り分けてくれる。
負荷分散としても利用できる。
MySQL Group Replication と合わせて使う時、マスタサーバーが変わった時でも自動で追随してくれる。
アプリケーションはマスタがどのサーバーかを意識する必要がなくなる。


# MySQL Shell

MySQLサーバー管理用のCLIツール。
Javascript、Python、SQLで管理コードが書ける。
MySQL Group Replicationで使う場合のサーバー設定を自動でうやってくれたり(my.confの設定など）MySQL Routerの設定、管理もできる。
バッチ処理によるサーバー管理処理も自動化できちゃう。
