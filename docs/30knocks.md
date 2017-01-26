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

## Q17 Through

```bash
$ while read f; do echo $f; done  < /etc/passwd > ~/a
$ echo "$(</etc/passwd)" > ~/a
```

リダイレクトとコマンド置換を使えばファイルを読めるのか。すごいな。

## Q18 Catch

```bash
$ echo 'i am a perfect human' | tr "[:lower:]" "[:upper:]"
$ echo pen-pineapple-apple-pen | sed -e 's/^p/P/' | sed -e 's/-p/-P/g' | sed -e 's/-a/-A/g'
```

一応出来たけど・・・。

```bash
$ echo i am a perfect human | (read a; echo ${a^^})
$ echo pen-pineapple-apple-pen | (IFS=-; read -a w; echo ${w[*]^})
```

難しいなぁ。


## Q19 Through

```bash
$ (IFS=:; while read -a w; do echo ${w[6]}; done < /etc/passwd)
```

難しい。ロジック自体はシンプルでbash構文を知ってるかどうか。

```bash
IFS=:
while read {a..g}
do
  case ${g} in
    */sh )
      sh=$(( ${sh} + 1 ));;
    */bash)
      bash=$(( ${bash} + 1 ));;
  esac
done < /etc/passwd
echo "bash: " ${bash}
echo "sh: " ${sh}
```

## Q20 Catch

```bash
$ git status | grep 'modified.*B' | awk '{print $2}' | xargs git add
```

問題とは言えまわりくどい。--

```bash
$ git ls-files -m | grep 'B' | xargs git add
```

`git ls-files` 初めて知った。余計な処理がいらなくなる。


## Q21 Catch

```bash
$ find -f . | grep -E '.css/.+|img/.+' | xargs git reset HEAD~
```

`$ find css img -type f` で事足りるのか。


## Q22 Through

```bash
$ git br -a --no-merged
```
この先どうしたらいいのか。

```bash
$ git branch -a --no-merged |\
while read branch; \
do
  git log -1 --since=$(date -d '1 month ago' +%Y-%m-%d) $branch |\
  grep -q . || \
  git log -1 --date=short --pretty=format:"%cd | %an | $branch " $branch
done
```

## Q23 Catch

```bash
$ git log --pretty=format:"%cd" --date=raw | awk 'BEGIN{prev=0} {if (prev != 0) { print (prev - $1)/(60 * 60); prev = $1 } else { prev = $1}}'
```
awk のifは変数を条件にしてやれば使わなくていい。formatも%ctを使う。
```bash
$ git log --pretty=format:"%ct" | awk 'prev{ print (prev-$0)/3600 }{ prev = $0}'
```

## Q24 Catch

```bash
$ seq 5 1 | awk '{for(i=0;i<$0-1;i++){ printf " " } print "X"}'
```
Linuxだと　`seq 5 -1 1` にしないといけないようだ。

## Q25 Catch

```bash
$ seq 1 99 | xargs -I_ ln hoge hoge_
```

ハードリンクとシンボリックリンクの違いとは。


## Q26 Catch

```bash
$ cat kaibun
たけやぶ
やけた
$ cat not_kaibun
やぶけた
やけた
$ a=$( cat kaibun | xargs -I_ echo -n _ ); b=$( echo -n $a | ruby -ne 'print $_.reverse' ); echo -n $a $b | awk '{ if ($1==$2){print "true"}else{print "false"} }'
true
$ a=$( cat not_kaibun | xargs -I_ echo -n _ ); b=$( echo -n $a | ruby -ne 'print $_.reverse' ); echo -n $a $b | awk '{ if ($1==$2){print "true"}else{print "false"} }'
false
```

反転は`rev`でできる。  
`xargs _I_ echo -n`は`xargs | tr -d ' '`でも同じ。  
`awk '$1==$2'` 一致したときだけ出力、にすればシンプル。  

`paste` `tee` `<( command )` プロセス置換。

```bash
$ paste <(grep -o . kaibun) <(grep -o . kaibun | tac) | awk '$1!=$2'
```
模範解答はさすが。


## Q27 Catch

```bash
$ seq 0 364 | xargs -I_ date -v1m -v1d -v+_d '+%m %w' | awk '$2==0' | uniq -c | awk '$1==5'
```

模範解答と考え方は同じ。


## Q28 Through

```bash
$ curl 'https://raw.githubusercontent.com/ryuichiueda/ShellGeiData/master/sd201701/crypt' -o crypt
$ cat crypt | base64 -d | gzip -d > b; chmod +x b; ./b | sed 's/..../\\U&/g' | sed 's/.*/echo -e "&"/' | bash
```

難しすぎる。`file` コマンドしらん。

## Q29 Catch

```bash
$ curl 'https://raw.githubusercontent.com/ryuichiueda/ShellGeiData/master/sd201701/alphabet_connection' -o alphabet
$ cat alphabet | xargs -n 1 | sort | xargs | ruby -nae '$F.each_with_index{|e,i| if (i==0); print e; else; if (e.ord==$F[i-1].ord+1); print "-#{e}"; else; print " #{e}" end; end}' | sed -E 's/([a-z])-[^ ]*-([a-z])/\1-\2/g'
```

困ったときのrubyプログラミング


## Q30 Through

```bash
$ echo $BASH_COMMAND
```

クワイン知らないん。なんか超越した考え方だった。
