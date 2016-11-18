# シェルビー芸

Rubyを使ってシェル芸やってみよう

## 動機

- Ruby使いたいからなんとか使う機会はないものか
- シェルでテキスト処理をする場合にうまくRuby使えないか


## ruby の文字列処理オプション

```
-e command     Specifies script from command-line while telling Ruby not to search the rest of the arguments for a script file name.

-n             Causes Ruby to assume the following loop around your script, which makes it iterate over file name arguments somewhat like sed -n or awk.

                     while gets
                       ...
                     end

-p             Acts mostly same as -n switch, but print the value of variable $_ at the each end of the loop.  For example:

                     % echo matz | ruby -p -e '$_.tr! "a-z", "A-Z"'
                     MATZ

-a             Turns on auto-split mode when used with -n or -p.  In auto-split mode, Ruby executes
                     $F = $_.split
               at beginning of each loop.

-F pattern     Specifies input field separator ($;).

-r library     Causes Ruby to load the library using require.  It is useful when using -n or -p.

-l             (The lowercase letter ``ell''.)  Enables automatic line-ending processing, which means to firstly set $\ to the value of $/, and
               secondly chops every line read using chop!.

```

- `-F` splitの区切り文字(`$;`)を指定。

- `-r` **library** プログラムを実行する前に指定されたライブラリをロードする。



### **-e**

`-e command` コマンドラインからrubyコードを与えます。
他のオプションを使う場合は最後に指定します。正規表現ショートカットが利用できます。

```sh
$ ruby -e "puts 'Hello, World.'"
```

複数の`-e`オプションが指定されている場合、1つ1つは別々のコード行として扱われます。

```sh
$ ruby -e 'a = "Hello"' -e 'b = "World"' -e 'puts [a,b].join(" ")'
Hello World
$ ruby -e 'a = "Hello"; b = "World"; puts [a,b].join(" ")'
Hello World
```

### **-n**

次の繰り返しに囲まれているのと同じようにプログラムを実行する。

```ruby
while gets            # 入力から1行を$_に読み込む
  $F = split if $-a   # -aが指定されていれば$_をフィールドに分割
  chop if $-l         # -lが指定されていれば$_の行末を取り除く

  # ここにプログラムを挿入!!!

  print if $-p
end
```

`gets` 読み込まれた文字列は暗黙的に`$_` に保持される。

```sh
$ cat ip_list.txt
118.151.171.74
54.197.246.21
192.30.252.153

$ ruby -ne 'puts $_' ip_list.txt
$ cat ip_list.txt | ruby -ne 'puts $_'
```

#### 暗黙的な `$_` 操作

`print` `chop` `chomp` `sub` `gsub`
これらのグローバル関数は暗黙的に `$_` を操作し、結果を `$_` に戻します。

```sh
$ cat ip_list.txt | ruby -ne 'print'
$ cat ip_list.txt | ruby -ne 'chop; print'
$ cat ip_list.txt | ruby -ne 'sub(".", "-"); print'
$ cat ip_list.txt | ruby -ne 'gsub(/[12]/, "X"); print'
```

### **-p**

`-n`オプションと同じように動作し、`$_` を出力します。
`$_` を暗黙的に扱う関数を使う場合に便利です。

```sh
$ cat ip_list.txt | ruby -pe ''
$ cat ip_list.txt | ruby -pe 'chop'
$ cat ip_list.txt | ruby -pe 'sub(".", "-")'
$ cat ip_list.txt | ruby -pe 'gusb(/[12]/, "X")'
```


### **-a**

自動で`$_`をsplitして`$F`にセットします。`-n`や`-p`と使うときのみ有効で`$F = $_.split` をループの戦闘で実行します。

```
$ ls -l | ruby -ane 'p $F'
["total", "64"]
["drwxr-xr-x", "21", "morisaki", "staff", "714", "11", "9", "12:18", "Applications"]
...

$ ls -l | ruby -ane 'p $F[0]'
"total"
"drwxr-xr-x"
...
```

## 特殊変数

## オプションと特殊変数をうまく使う

### 組み合わせ

# sed awk の代替になるのか

## post sed

## post awk

## original trick

ruby ならではの使い方

lambda 式

# 外部スクリプトにする


# 参考

- [Rubyの特殊変数一覧](https://gist.github.com/kwatch/2814940)
- [Rubyワンライナー入門](http://maeharin.hatenablog.com/entry/20130113/ruby_oneliner)
- [プログラミング言語Ruby](http://amzn.to/2govaCN)

