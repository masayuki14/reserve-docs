# SoftwareDesign 2017.01 shell 30 knocks.

## Q1 Catch

`.exe` という拡張子を持つファイルを抜き出す。

```sh
$ grep -R '\.exe$' files.txt
$ awk '/\.exe$/' files.txt
$ cat files.txt | ruby -ne 'print if /\.exe$/'
```

`\.exe$` を使うのがポイント
files.txt  http://bit.ly/2iqCqdd


## Q2 Catch

poolの項目にあるIPもしくはホスト名を抽出。コメント行は対象外。

```sh
$ cat ntp.conf | awk '/^pool/ {print $2}'
$ ruby -nae 'puts $F[1] if /^pool/' ntp.conf
```

コメント行の除外はいらないんじゃないか。
ntp.conf http://bit.ly/2iqG33c


## Q3 Through

```sh
$ cat du.s | sort -nr | awk '{print $2}' | xargs du -sh
```

`xargs` を使ってやり直すのか。なるほど。
