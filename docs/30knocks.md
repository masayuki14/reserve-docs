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


## Q4 Catch

```sh
$ ls -l /bin/ | ruby -nae 'print $_ if $F[0] =~ /s/'
$ ls -l /bin/ | awk '$1~/s/'
```

ruby 使えたらほぼなんでもできそうな気がしてきた。
`awk '$1~/s/'` これやりたかったけどできんかった。
`s` の存在も意味も初めて知った。


## Q5 Catch

```sh
$ cat log_range.log | sed -n -e '/24\/Dec\/2016 21/,/25.*2016 03/p'
$ cat log_range.log | ruby -ne 'p=true if ~/24\/Dec\/2016 21/; print if p; p=false if ~/25\/Dec\/2016 03/'
```
`awk` でもできるのか！

log_range.log http://bit.ly/2ih96JR


## Q6 Through

```sh
$ find . | awk -F'/' '{ c[$2] +=1} END{ for(i in c){ print i, " " c[i]} }'`
```

ぜんぜんちがった。
