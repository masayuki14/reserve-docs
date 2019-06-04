# Compose on Kubernetes をGKEで動かす話
    Cloud Native Kansai #03
    2019/06/07

# agenda

- compose on k8s
    - ローカルならわりとすぐ動く
    - GKE ドキュメントどおりでも動かない
    - Issue出すもレスオンスなし

- gke で動かせなかった
    - Github Issue で報告
    - 同じような人がいた
    - レスなし

- Docker CLI
    - 現行バージョンはだめ
    - 最新のビルドが必要
    - docker/cli

- 得られた知見
    - 本を読もう
        - gcloudの認証やkubectlの話はREADMEにはない
        - 丸腰でのGKEインストールは出来なかっただろう
    - GCP $300 の無料枠1年使える
    - プライベートのレジストリを使おう
        - registry コンテナで簡単に使える
    - コントリビュートしよう
    - 動かすことで理解が深まる
        - etcd
        - Helm
        - gcloud
        - kubectl
`






# Compose on k8s

  * 前回のLTで出てきた
  * docker-compose.yaml をKubernetesクラスターにデプロイできます。

  > Compose on Kubernetes allows you to deploy Docker Compose files onto a Kubernetes cluster.
  > https://github.com/docker/compose-on-kubernetes


# コマンド

ローカルで実行

```
$ docker stack deploy -c docker-compose.yml --orchestrator=kubernetes kubesample
```

# GKE で動かすには

公式ドキュメント

- GKEのk8sクラスタ
- Helm
- Installer
- 大きな問題はない


# Gcloud 認証

```
$ gcloud auth login

$ docker stack deploy -c docker-compose.yml --orchestrator=kubernetes kubesample
```

# 結果

動かない

おわり！！


# GitHub Issue

いくつか Issue だす
