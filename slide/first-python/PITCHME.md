# はじめての Hello Python

---

# 自己紹介

## 森崎 雅之

## @masayuki14

---

# 自己紹介

- 主夫
- パートタイムプログラマ
- スプーキーズアンバサダー

---

## スプーキーズ

## スマホゲーム ✕ ボードゲーム

<img src="http://spookies.co.jp/images/spookies_logo.png" style="width: 300px" />

---

## スプーキーズ

## メンバー募集中

<img src="http://spookies.co.jp/images/spookies_logo.png" style="width: 300px" />

---

# 今日する話

## はじめての Hello Python

---

# 今日する話

- バージョン
- 実行環境
- ほかのLLとの違い

---

## バージョン

# 2系と3系どっちをえらんだらいいの？

- python 2.7
- python 3.6

---

## バージョン

## python.orgによると

- 言語としては3系が成熟している
- 3系を使用したくない人は少数派
- 2系のサポートは2020年で終了

https://wiki.python.org/moin/Python2orPython3

---

## バージョン

## 今から始めるなら

# Python 3

---

## 環境

## on Mac

- brew
- pyenv
- Docker

---

## 環境

# brew

```console
$ brew install python3

$ python3
```

---

## 環境

# pyenv

```console
$ brew install pyenv

$ echo 'eval "$(pyenv init -)"' >> ~/.bash_profile

$ pyenv install [version]
```

---

## 環境

# Docker

```Dockerfile
FROM python:latest
```

```console
$ docker build .
$ docker run -it --rm python3 /bin/bash
```

---

## ほかのLLとの違い

- ruby
- perl
- etc


---

## ほかのLLとの違い

# バイトコンパイル

---

## python処理系

- コードを解析 |
- 仮想マシン用のバイトコードに変換 |
- 仮想マシンで実行 |

---

## バイトコンパイル

# 事前にバイトコードにして保存して

---

## バイトコンパイル

# 高速化できる！！

---

## まとめ

- バージョンは3系を使おう |
- Macなら簡単に使える |
- バイトコードは速い |

---

## さいごに

```
$ python3 -c 'print("Hello Python!")'
Hello Python!
```

