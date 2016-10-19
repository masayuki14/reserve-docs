# Let's Try Shell Tricks

やってみようシェル芸。

## シェル芸ってなんだろう？

マウスも使わず  
プログラムも書かず  
GUIツールを立ち上げる間もなく  
あらゆる調査・計算・ファイル処理を  
**コマンド入力一撃** で終わらす。


## シェルでテキスト処理

テキスト出力をするコマンドを  
パイプで次々と繋いで処理をし  
目的の結果を得ること。


## Unixという考え方

背景にあるもの。

- 数値データはASCIIフラットファイルに保存する
- 1つのプログラムには1つのことをうまくやらせる
- シェルスクリプトによって梃子(てこ)の効果と移植性を高める
- すべてのプログラムをフィルタとして設計する

などのUnix設計思想が背景にあります。

「[Unixという考え方](http://amzn.to/2bjH3Gd)」という書籍を読みましょう。

# 覚えたいコマンド

- `cat`
- `grep`
- `head` `tail`
- `sort`
- `uniq` `wc`
- `xargs`
- `sed`
- `awk`

## cat (表示・連結)

ファイルの出力と連結を行ないます。複数のファイルを指定することで内容を連結して表示します。

```
$ cat access_log.1 access_log.2
```

- `-n` 行番号表示。
- `-b` 行番号表示、ただし空行は表示しない

```
$ cat -n /etc/hosts /etc/shells
$ cat /etc/hosts /etc/shells | cat -n
```

- ファイルごとの行番号表示
- 全体での行番号表示


## grep (検索)

正規表現の検索パターンに一致する行を出力します。  
`$ grep '<検索パターン>' [ファイル]`

プログラムで使われているクラスやメソッドを検索する際に頻繁に使います。  

- `-n` 行番号表示
- `-i` 大文字小文字を区別しない(ignore case)
- `-r` 再帰的に検索(recursive)
- `-I` バイナリファイル無視
- `-v` 一致しない行を表示

```
$ grep -rinI '_process_attack_turn' pm/
```
```
# コメント行削除
$ grep -v '^\s*#' /etc/shells
```

## head

ファイルの先頭を出力します。

- `-n` 指定数の行を出力

```
$ head -n 5 /etc/group
root:x:0:
daemon:x:1:
bin:x:2:
sys:x:3:
adm:x:4:syslog,ubuntu
```

## tail

ファイルの末尾を出力します。

- `-n` 指定数の行を出力
- `-r` 逆順に出力
- `-f` EOFに達しても出力を続け、データが追記されれば出力する

```
$ tail -n 5 /etc/group
mysql:x:113:
ssl-cert:x:114:
postfix:x:115:
postdrop:x:116:
munin:x:117:
```

```
$ tail -f access_log
```

## sort(整列)

ファイルを連結してソートし出力します。

- `-r` 逆順に出力
- `-k` 指定のキーでソート
- `-n` 数値としてソート

```
$ ls -l /var/log/nginx/ | grep -v 'total' | sort -k5 | head -n 5
-rw-r----- 1 www-data adm   1022 Feb 27  2016 error.log.28.gz
-rw-r----- 1 www-data adm  10550 Feb  8  2016 access.log.31.gz
-rw-r----- 1 www-data adm  11430 Oct 11  2015 access.log.48.gz
-rw-r--r-- 1 root     root 11528 Sep 20  2015 error.log.51.gz
-rw-r--r-- 1 root     root 11631 Sep 20  2015 access.log.51.gz
```
```
$ ls -l /var/log/nginx/ | grep -v 'total' | sort -k5 -n | head -n 5
-rw-r----- 1 www-data adm   1022 Feb 27  2016 error.log.28.gz
-rw-r----- 1 www-data adm   1398 Sep  5 12:43 error.log
-rw-r----- 1 www-data adm   1481 Nov  8  2015 error.log.44.gz
-rw-r----- 1 www-data adm   1638 Mar  7 06:29 error.log.27.gz
-rw-r----- 1 www-data adm   1848 Sep  5 12:43 access.log
```

## uniq(数え上げ)

隣接する重複する行を除外します。  
そのためこのように連続しない場合は重複を除外できません。  
`sort` されているのが前提です。

```
$ cat << EOF | uniq
hello
hi
hello
EOF
```

- `-c` 重複数を数えます
- `-d` 重複する行だけ出力します
- `-u` 重複がない行だけ出力します

```
$ cat << EOF | sort | uniq -c
hello
hi
hello
EOF
   2 hello
   1 hi
```


## xargs

標準入力から受けた値を、任意のコマンドに引数として渡します。

- `-I` 置き換え文字を指定します。
- `-n` 指定の数で引数を区切ります。

```
# 指定ファイルを消す
$ find . -name \*~ | xargs rm

# 指定ファイルだけgrepする
$ find script -name \*.pl | xargs -I= grep -rin 'use Time' =
```

```
# コマンド指定なし
$ l=''; for i in {1..31};  l="$l $i"; echo $l | xargs -n 7
1 2 3 4 5 6 7
8 9 10 11 12 13 14
15 16 17 18 19 20 21
22 23 24 25 26 27 28
29 30 31
```

## sed

文字列の置換などいろいろな編集を行います。

```
# masa -> XXX に置換
$ ls -l | sed -e 's/masa/XXX/g'

# 3行目から8行目を出力
$ ls -l | sed -n -e '3,8p'
```

他にもいろいろできるYO

## awk

テキストストリーム処理に特化したコマンド。

awkの処理は入力の1行ずつに対してパターンを含むか調査し、
含む場合は対応するアクションを実行します。
```
# 基本的な構文

$ awk ' /pattern1/ { actiion } /pattern2/ { action } '
```

awkはレコード(1行)を処理単位とし特定の区切り文字でフィールドに分けられます。
それぞれ特別な変数 $0, $1, $2 ... に格納されます。


```
$ cat data.txt
Morisaki 34 100
Nishizuka 40 99
Ashida 25 70
Terano 26 88
Nishimura 36 14
Wakaman 21 000000000000000000
```

```
# 1列目と3列目表示
$ awk '{ print $1, $3 }' data.txt
Morisaki 100
Nishizuka 99
Ashida 70
Terano 88
Nishimura 14
Wakaman 000000000000000000
```

```
# Nishi だけ表示
$ awk ' /Nishi/ { print $0 }' data.txt
Nishizuka 40 99
Nishimura 36 14
```



# チャレンジ シェル芸

## 問1

`/etc/password` からユーザー名を抽出したリストを作ってください。

- 使いそうなコマンド `sed`, `awk`, `tr`, `cut`, ....

```
$ cat ans
root
bin
daemon
adm
lp
sync

```

## 問2

`/etc/password` から次を調べてください。
ログインシェルが `bash`のユーザーと `sh` のユーザーどちらが多い？

```
$cat ans
      4 /bin/bash
      1 /bin/sh
```

[シェル芸勉強会 問題一覧](https://blog.ueda.asia/?page_id=684)
