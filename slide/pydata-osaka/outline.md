
はんなりPython+PyData Osakaの可視化特集会
2019/03/24


# Dockerを使った可視化環境の作り方


Dockerを使う

+-------+       +-------+        +---------+
| Dash  | ----- | MySQL | ====== | Jupyter |
+-------+       +-------+        +---------+
                    |
                    |            +---------+
                    +----------- | adminer |
                                 +---------+

# 困ったこと

- Pythonにはまだあまり慣れていない
    - 動かしながら使いたい
- pyPIライブラリでMac汚したくたい
    - というか管理しきれない
    - venv pyenv もよくわからない
- 仮想化はしたい
- Pandasよくわかんない

# モチベーション

- Dash使いたい
- データ可視化したい
- 興味ある
- Webは得意
- MySQLは得意



# ストーリーどうするか

- ハンズオンでDashを知る。
- 簡単に可視化できそう
- でも興味のあるデータがない
- 懇親会で目標がきまる
- 待ち時間可視化アプリをつくろう
- 目的が決まるととを動かせる

- でも困ったことがある
- とりあえずDockerを使えばいいか
    - 使い慣れたものでうまくまわす
    - Dashの環境が簡単に作れた！
- Pandas使えなーい。
    - CSVのデータはあるけど目的の形にできない涙
    - データ操作のストレスが爆発
    - MySQLにいれちゃえ
    - MySQLコンテナ追加
    - ついでにGUIツールも
- PandasからもSQLでデータ取れる
    - MySQLである程度扱いやすデータに加工しておく
    - Pandasでやるのは最低限のことですんだ
- Python慣れてない
    - 書きながらやりたい
    - Jupyterだ！
    - MySQLにもつなぎたい
    - Jupyterコンテナ
- 動かしながら作る環境ができてきた。

- メインPC iMacでMacBookも使うから環境をコピーできるのが楽

どうなってるか。

```yaml
version: '3.7'
services:
  dash:
    build:
      context: ./dockerfiles
      dockerfile: Dockerfile.dash
    container_name: di_dash
    command: ["python", "/work/dash/app.py"]
    working_dir: /work
    depends_on:
      - db
    volumes:
      - ./:/work
      - ./logwh:/log
    ports:
      - 8050:8050

  jupyter:
    build:
      context: ./dockerfiles
      dockerfile: Dockerfile.jupyter
    depends_on:
      - db
    volumes:
      - ./jupyter-workspace:/home/jovyan/work
      - ./logwh:/log
    ports:
      - 10000:8888

  db:
    image: mysql:8.0
    container_name: di_mysql
    command:
      - --default-authentication-plugin=mysql_native_password
      - --secure-file-priv=/log
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQ_DATABASE: disney
    ports:
      - 3306:3306
    working_dir: /work
    volumes:
      - ./db/mysql/datadir:/var/lib/mysql
      - ./db/mysql/log:/var/log/mysql
      - ./db:/work
      - ./logwh:/log

  adminer:
    image: adminer
    restart: always
    ports:
      - 8080:8080

```

# 環境の解説

- Dockerってなんだ
- 構成
- docker-compose.yml の解説
- デモ
    - clone
    - dbセットアップ
