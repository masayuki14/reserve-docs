# Anaconda と Miniconda

---

# 自己紹介

## 森崎 雅之

## @masayuki14

- Twitter
- GitHub
- Hatena

---

# 自己紹介

- 主夫
- パートタイムプログラマ
- スプーキーズアンバサダー

---

## スプーキーズ

## ソシャゲ ✕ ボドゲ

<a href="http://spookies.co.jp/"><img src="http://spookies.co.jp/images/spookies_logo.png" style="width: 300px" /></a>

---

## スプーキーズ

## メンバー募集中

<a href="http://spookies.co.jp/"><img src="http://spookies.co.jp/images/spookies_logo.png" style="width: 300px" /></a>

---

## 今日する話

## Anaconda と Miniconda

---

## Anacondaとは

Anaconda はデータサイエンス向けに作成された Pythonパッケージで、科学技術計算などを中心とした数多くのモジュールやツールが独自の形式で同梱されています。

### at macOS, Linux

Anaconda を使わなくとも、通常の pip コマンドでも簡単に環境を構築できます。

### at Windows

簡単にインストール可能なモジュールが提供されていない環境で、機械学習などのためにPython を使用するなら、多くのモジュールがデフォルトでインストールされる Anaconda はとても便利です。


### 注意点

- Anaconda は一部に独自技術を使用しているため、公式パッケージでは一般的に使用されているツールなどでも、Anaconda では利用できないものがある
- Anacondaは標準的な Pythonの 仮想環境 を利用できないため、専用の Conda コマンド を利用する必要がある

---

## Minicondaとは

Anaconda の軽量版。Anaconda を最小限の構成にしたもので、同様に Conda コマンドをお利用する。


---

## Conda コマンド

- パッケージの管理
    - pip の代わりに使います。
    - pip でもインストールできます。

- バージョンの管理
    - pyenv の代わりにつかいます。

- 仮想環境管理
    - virtualenv/venv の代わりに使います。

---

# Conda 最高

---

## まとめ

- Minicondaの方が軽量
- データサイエンスやるならMinicondaを使う
- なれないうちは `Conda` コマンドだけ使う

---

## Minicondaをうごかしてみよう

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

[how to install](https://conda.io/docs/user-guide/install/linux.html)

---

## チュートリアルをやってみる

[Building conda packages with conda skeleton](https://conda.io/docs/user-guide/tutorials/build-pkgs-skeleton.html)
https://conda.io/docs/user-guide/tutorials/build-pkgs-skeleton.html

---

## skelton コマンド実行

```
$ cd
$ conda skeleton pypi pyinstrument
```

`pyinstrument` ディレクトリが作られ `meta.yaml` ができた

## build.sh bld.bat のダウンロード

```
$ cd pyinstrument
$ curl -L 'https://conda.io/docs/_downloads/build1.sh' -o build.sh
$ curl -L 'https://conda.io/docs/_downloads/bld.bat' -o bld.bat
```

## conda-build でパッケージを作れる！？

```
$ cd ../
$ conda-build pyinstrument
```

## Error でた。。。

`Troubleshooting a sample issue` の問題とはちがった。


