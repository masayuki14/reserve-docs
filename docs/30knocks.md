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
$ cat log_range.log | ruby -ne 'print if /24\/Dec\/2016 21/../25\/Dec\/2016 03/' # これでいける
```
`awk` でもできるのか！

log_range.log http://bit.ly/2ih96JR


## Q6 Through

```sh
$ find . | awk -F'/' '{ c[$2] +=1} END{ for(i in c){ print i, " " c[i]} }'`
```
ぜんぜんちがった。

```sh
# answer
$ find . -type d | while read d; do echo -n $d" "; find "$d" -type f -maxdepth 1 | wc -l; done
```
`while read f; do command $f ; done` のイディオムをうまく使う。
`-type` `-maxdepth` のオプションを知った。



## Q7 Catch

```sh
$ ps aux | awk '(NR>1) { c[$1]+=$3; m[$1]+=$4 } END{ for(i in c) print i, c[i], m[i] }' | sort -rn -k2,3
```

プロセスの件数をカウントしてもよい。


## Q8 Through

```sh
$ wget example.com/big_file.tar.gz && mail -s 'Success' my.mail@example.com <<< '' || mail -s 'Failed.' my.mail@example.com <<< ''
```

さっぱりわからなかった。 `&&` `||` はbash演算子で終了ステータスを判定する。

## Q9 Catch?

```sh
$ tailf access.log | awk '($9==500){print}{fflush()} | xargs -I_ mail -s '500 Fail.' my.mail@example.com <<< "_"
```

`&` でバックグラウンドにすると良い。`mail` がうまく動かず未確認。たぶん動くと思う。  
`tailf` は `awk` や `grep` などバッファしないオプションのあるコマンドを使わないといけないようだ。


## Q10 Through

これは無理

```sh
$ openssl s_client -host twitter.com -port 443 < /dev/null 2> /dev/null | openssl x509 -text | grep 'Not After'
```

`openssl` コマンド使ったことありません。

## Q11 Through

これもわからない

```sh
$ echo '@reboot /bin/sleep 180 && /sbin/poweroff' | sudo crontab
```

## Q12 Catch

bash 自体はよくわからんがなんとか。

```sh
$ seq 1 100 | while read n; do sleep 1 ; echo "羊が$n匹"; done
```

```bash
#!/bin/bash

n=1
while [ $n -le 100 ]
do
  echo -e "羊が$n匹"
  n=$((n + 2))
  sleep 1
done
```

`[` は `test` の別名でオプションを覚えるといい。  
`$(( 3 * 8 ))` 算術式展開  
`$(seq 1 10)` コマンド置換  


## Q13 Catch

```sh
$ echo -e '\U1F37A' '\U1F363'
```

## Q14 Through

```sh
$ set | grep VER
```

`zsh`だとsetの出力をgrepできない。なんでだろう。

## Q15 Catch

```bash
#!/bin/bash

function double () {
	for n in $@ ; do
		echo -n $(( n * 2 )) ' '
	done
	echo
}

if [ -p /dev/stdin ] ; then
	double $( cat /dev/stdin )
else
	double $@
fi
```

bashプログラミング慣れない。

```bash
#!/bin/bash
num=${1:-$(cat)}
echo $(( $num * 2 ))
```

`:-` `:=` `:+` `:?` とか分からない。
http://qiita.com/bsdhack/items/597eb7daee4a8b3276ba


## Q16 Catch

```
$ rm -rf ./~
$ rm -rf ./-Rf
```

`--` でオプション打ち止めとなる。
```sh
$ rm -rf -- -Rf
```
