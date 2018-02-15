<div style="font-size: 0.89em;">
<h1>Jupyter Notebook 入門</h1>
</div>

## はんなりPython #3

### 2018/02/16

---

## 自己紹介

### 森崎雅之

### @masayuki14

<img src="./twitter.png" style="width: 180px; background-color: white;" />
<img src="./github.png"  style="width: 180px; background-color: white;" />
<img src="./hatena.png"  style="width: 180px; background-color: white;" />

Follow me !!

---

## 自己紹介

- コミュニティ
    - はんなりPython
    - OSS Gate
- 主夫
    - 兼 パートタイムプログラマ
    - 兼 スプーキーズアンバサダー

---

## スプーキーズ@京都

### ソーシャルゲーム ✕ ボードゲーム

<a href="http://spookies.co.jp/">
<img src="http://spookies.co.jp/images/spookies_logo.png" style="width: 300px; background-color: white;" />
</a>

---

## スプーキーズ@京都

### 社内勉強会やってます

- WebRTCを活用する
- Docker勉強会
- ゲームAIを作って競い合う構想

---

## スプーキーズ@京都

### エンジニア勉強会 #1　3/23(金)

connpass 79323

---

## スプーキーズ@京都

### Webエンジニア募集中

---

## 今日する話

<div style="font-size: 0.89em;">
<h1>Jupyter Notebook 入門</h1>
</div>

---

## 今日する話

### Jupyter Notebook とは
### Use Jupyter Notebook
### Use Pandas
### 身近なデータを可視化しよう

---

## Jupyter Notebook とは

### Project Jupyter

複数のプログラミング言語にまたがるインタラクティブコンピューティングのためのサービスを開発する

---

## Jupyter Notebook とは

Project Jupyter のサービスの一つ

ライブコード、方程式、可視化、テキストを含むドキュメントを作成して共有できるオープンソースのWebアプリケーション

---

## Use Jupyter Notebook

### by Docker

```
FROM python:latest

# Install miniconda to /miniconda
RUN curl -LO 'https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh'
RUN bash Miniconda3-latest-Linux-x86_64.sh -b -p /miniconda
ENV PATH=/miniconda/bin:${PATH}
RUN conda update -y conda

# install for jupyter notebook
RUN conda install -y pandas matplotlib nb_conda
RUN conda install -y pyyaml

RUN mkdir -p /root/notebook
WORKDIR /root/notebook

CMD jupyter notebook --ip=0.0.0.0 --allow-root
```
@[1](ベースにpythonの最新バージョン)
@[3-7](Minicondaをインストール)
@[9-11](必要なライブラリをインストール)
@[13-16](jupyterを実行してWebサーバーを起動)

---

## Use Jupyter Notebook

Build image

```
$ docker build -t jupyter .
```

Run docker

```
$ docker run -it --rm -v $(pwd)/notebook:/root/notebook -p 80:8888 jupyter
```

---

## Use Jupyter Notebook

```
    Copy/paste this URL into your browser when you connect for the first time,
    to login with a token:
        http://0.0.0.0:8888/?token=ba4fc6de0d99161f5e144ad4c1167ebf074ddc29b916065f
```

---

## Use Jupyter Notebook

http://localhost/?token=ba4fc6de0d99161f5e144ad4c1167ebf074ddc29b916065f

にアクセス！！


---

## Use Jupyter Notebook

<img src="jupyter_home.png" />

---

## Use Jupyter Notebook

### Hello world

```
def hello():
    return 'Hello Jupyter.'

hello()
```

```
'Hello Jupyter.'
```

---

## Use Jupyter Notebook

### グラフ表示

```
# グラフ表示を有効化
%matplotlib inline
import pandas as pd

df = pd.DataFrame([1,1,2,3,5,8,13,21,34,55,89,144,233,377,610,987,1597,2584,4181,6765])
df.plot()
```

<img src="fibo_graph.png" />

---

## Use Jupyter Notebook

### グラフ表示

```
fibo_pd.describe()
```

```
count	20.000000
mean	885.500000
std	1752.704452
min	1.000000
25%	7.250000
50%	72.000000
75%	704.250000
max	6765.000000
```


---
## まとめ

- Minicondaの方が軽量
- データサイエンスやるならMinicondaを使う
- なれないうちは `Conda` コマンドだけ使う

---

# Minicondaをうごかす

---

## Dockerで動かす

```
# Dockerfile
FROM python:latest

# Install miniconda to /miniconda
RUN curl -LO 'https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh'
RUN bash Miniconda3-latest-Linux-x86_64.sh -b -p /miniconda
ENV PATH=/miniconda/bin:${PATH}
RUN conda update -y conda

RUN conda install -y conda-build
RUN conda update  -y conda-build
```

```
$ docker build -t miniconda .
$ docker run -it --rm miniconda /bin/bash
```

---

# チュートリアルをやる

https://conda.io/docs/user-guide/tutorials/build-pkgs-skeleton.html

---

<img src="./tutorial.png" style="" />

---

## Building conda packages with conda skeleton

すでにPyPI上で利用可能なPythonモジュール用のcondaパッケージを構築する

---

## PyPI
## the Python Package Index

- pythonパッケージのリポジトリ
- 登録すると `pip install XXX` でインストールできる

---

## 1. skelton コマンド実行

```
$ cd
$ conda skeleton pypi pyinstrument
```

`pyinstrument` ディレクトリが作られ `meta.yaml` ができた

---

## 2. build.sh bld.bat のダウンロード

```
$ cd pyinstrument
$ curl -L 'https://conda.io/docs/_downloads/build1.sh' -o build.sh
$ curl -L 'https://conda.io/docs/_downloads/bld.bat' -o bld.bat
```

---

## conda-build でパッケージを作成

```
$ cd ../
$ conda-build pyinstrument
```

---

## Error でた

```
$ conda-build pyinstrument
Adding in variants from internal_defaults
INFO:conda_build.variants:Adding in variants from internal_defaults
Attempting to finalize metadata for pyinstrument
INFO:conda_build.metadata:Attempting to finalize metadata for pyinstrument
Solving environment: failed


...
```

いろいろ探すも解決せず。

---

## Issue 報告

同じような問題のIssueが立っていたので追記する。

https://github.com/conda/conda-build/issues/2628#issuecomment-358836316

---

## Issue 報告

<img src="./issue.png" />

---

## 6分後回答きた

<img src="./issue-response.png" />

---

## 6分後回答きた

`$ conda skeleton pypi --recursive pyinstrument`

を使え！とのこと

---

## やっぱりダメ

---

## ということで今回はこれまで

---

## 今後のこと

---

## チュートリアルの突破を目指す

---

## チュートリアルのドキュメントを修正してPRだす

---

## マージされる

---

## 次の人がうまくいく

---

## 今日は失敗談でした

---

## まだPythonのコードは書いてない

---

## ありがとうございました
