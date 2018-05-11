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


# Replication

# Replication

- データの複製を別サーバーにもたせる
- MySQLの標準機能
- Master -> Slave という構成


![](Master_Slave.png)

# Replication Topology

![](Topology.png)

![](Topology-tree.png)

# Replication 参照性能の向上

![](dispersion.png)

スレーブを増やし負荷分散を行う


# MySQL InnoDB Cluster

# MySQL InnoDB Cluster

3つのコンポーネントを組み合わせて作るMySQLの高可用性構成。

# MySQL InnoDB Cluster

構成要素
:   - MySQL Group Replication
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


# MySQL Group Replication

# MySQL Group Replication


- フェイルオーバーが自動化
- 構成の拡張・縮小が容易
- 単一障害点がない
- 自動再構成

MySQL 5.7.17 以降で利用可能

# MySQL Group Replication

全ノードがマスターで等価の関係のグループを構成
MySQL側でのフェイルオーバー処理が不要

![](FailOver.png)

# MySQL Group Replication

全ノードがマスターで等価の関係のグループを構成
MySQL側でのフェイルオーバー処理が不要

![](FailOverX.png)

# MySQL Group Replication

シングルプライマリモード

![](SInglePrimary.png)

- Primary: 更新できるマスタ
- Secondary: 参照およびスタンバイ

# MySQL Group Replication

シングルプライマリモード

![](SInglePrimary-promotion.png)

- プライマリーに障害があれば別インスタンスが昇格

# MySQL Group Replication

シングルプライマリモード

![](SInglePrimary-comback.png)

- セカンダリーとして復帰

# MySQL Router


# MySQL Router

- MySQL Connectionの振り分け
- ラウンドロビン
- 自動検出
- メタデータ・キャッシュ

# MySQL Router

![](MySQL Router.png)

- 設定、メタデータに基づき接続

# MySQL Router

![](MySQL Router-FailOver.png)

- メタデータを更新し参照先を変える


# MySQL Shell


# MySQL Shell

MySQL運用管理のためのCLIツール

- JavaScript, Python, and SQL
- 開発と管理用に完全なAPIを提供
- バッチ処理の実行


# MySQL Shell

MySQL InnoDB Cluster 管理用API

- クラスター作成
- MySQLインスタンスの構築
- クラスターの状況を確認可能
- MySQLインスタンスの開始・停止
- MySQLインスタンスの検証 ...


# Demo

# Demo

## 説明

Javascript、Python、SQLで管理コードが書ける。
MySQL Group Replicationで使う場合のサーバー設定を自動でうやってくれたり(my.confの設定など）MySQL Routerの設定、管理もできる。
バッチ処理によるサーバー管理処理も自動化できちゃう。
