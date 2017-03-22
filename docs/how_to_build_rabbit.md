# Rabbit を clone

http://rabbit-shocker.org/ サイトのソースコードもRabbitと同じリポジトリにあります。
Rabbitのリポジトリをクローンします。

```
$ git clone https://github.com/rabbit-shocker/rabbit.git
```

サイトのソースコードは `doc/` ディレクトリにあります。

# Gem のインストール

開発に必要なライブラリをBundlerでインストールします。

```
$ cd rabbit
$ bundle install --path vendor/bundle
```

# Rake タスクで開発サーバーを立ち上げる

```
$ bundle exec rake doc:server
```

`doc:server` タスクを実行するとWebServerが立ち上がり `http://127.0.0.1:4000/index.html.ja' にアクセスしてください。
Rabbit ウェブサイトのホームページが表示されます。
