はんなりPythonの会 #17 令和最初の発表会
2019/05/17


# Docker から Kubernetesまでを簡単に解説

- 話の核を何にするか。
    - それぞれの技術の何が嬉しいか
    - 何が大変でおそれをどう補うか
        - docker => docker-compose
        - docker-compose => docker-swarm
        - docker-swarm => k8s

- Dockerの基礎概念

- Dockerのうれしいこと
    - 環境の再現性
    - 軽量
        - VMより軽い
        - オーバーヘッドが少ない
    - 簡易
        - Dockerfile
        - コマンド

- Dockerの苦手なところ
    - 複数のコンテナを協調させてつかうのが面倒
    - コマンドのオプションが多くなってくる
    - 管理しづらい
    - Docker Compose を使う




- Docker Compose のうれしいところ
    - コンテナを郡として扱う
        - 複数のコンテナを扱える
    - 元々はFig
    - buildと実行同時にできる

- Docker Compose の苦手なところ
    - 単一ホストでの構成
    - 複数ホストで配置できない
    - 冗長化するには？
        - Docker Swarmを使う


- Docker Swarmのうれしいところ
    - 複数のDockerホスト（サーバー）を束ねる
    - クラスタ化
    - コンテナオーケストレーション
        - コンテナ配置
        - コンテナ間通信
    - コンテナのスケール
        - Service, Stack

- Docker Swarm の大変なところ
    - クラスタ作らないといけない
    - コマンド操作が多く管理しずらい
    - ネットワークの管理が煩雑

- k8sのよいところ
    - コンテナオーケストレーション
    - コンテナ運用の自動化
        - コンテナ配置
        - ホストん管理
        - スケーリング
    - 高機能
    - Google謹製 OSS (Borg)
    - クラウドで使える
        - GKE EKS AKS

- k8sの苦手なところ
    - 学習コスト高い
