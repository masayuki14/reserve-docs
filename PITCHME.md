# Jupyter Notebook 入門

## はんなりPython #3
### 2018/02/16

---

## 自己紹介

### 森崎雅之

### @masayuki14

<img src="./twitter.png" />
<img src="./github.png" />
<img src="./hatena.png" />

Follow me !!

---

## 自己紹介

- コミュニティ
    - はんなりPython
    - OSS Gate

- 主夫
- パートタイムプログラマ
- スプーキーズアンバサダー

---

## スプーキーズ@京都

## ソシャゲ ✕ ボドゲ

<a href="http://spookies.co.jp/"><img src="http://spookies.co.jp/images/spookies_logo.png" style="width: 300px" /></a>

---

## スプーキーズ@京都

## 社内勉強会やってます

- WebRTCを活用する
- Docker勉強会
- ゲームAIを作って競い合う構想

---

## スプーキーズ@京都

## エンジニア勉強会開催

### エンジニア勉強会 #1　3/23(金)

---

## スプーキーズ@京都

### Webエンジニア募集中

---

## 今日する話

## Jupyter Notebook 入門

---

## Anacondaとは

- Anaconda はデータサイエンス向けに作成されたPythonパッケージ
- 科学技術計算など数多くのモジュールやツールが独自の形式で同梱されている

---

### at macOS, Linux

Anaconda を使わなくとも、通常の pip コマンドでも簡単に環境を構築できる

### at Windows

機械学習などのためにPython を使用するなら、多くのモジュールがデフォルトでインストールされる Anaconda はとても便利


---

### 注意点

- Anaconda は一部に独自技術を使用している
    - 公式パッケージで利用できないものがある
    - 標準的な Pythonの 仮想環境 を利用できない
    - 専用の Conda コマンド を利用する必要がある

---

## Minicondaとは

Anaconda を最小限の構成にしたもの

---

## Conda コマンド

- パッケージの管理
    - pip の代わりに使う
    - pip でもインストールできる

- バージョンの管理
    - pyenv の代わりにつかう

- 仮想環境管理
    - virtualenv/venv の代わりに使う

---

# Conda 最高

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
