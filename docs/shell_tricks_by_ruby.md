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

- `-r` **library** プログラムを実行する前に指定されたライブラリをロードする。



### **-e _スクリプト_**

コマンドラインから与えられたスクリプトをrubyコードとして実行します。
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
while gets              # 入力から1行を$_に読み込む
  $F = $_.split if $-a  # -aが指定されていれば$_をフィールドに分割
  chop if $-l           # -lが指定されていれば$_の行末を取り除く

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

### **-F_フィールドセパレータ_**

`split`が使うデフォルトのフィールドセパレータ`$;`にコマンドラインから与えられた_フィールドセパレータ_を設定します。
フィールドセパレータは１文字でも任意の正規表現でも可能です。
内容を確認したい時は `$;` を出力してみましょう。正規表現となるので **.** などを扱う時は注意が必要です。

```sh
$ echo hi | ruby -F123 -nae 'p $;'
/123/

$ echo hi | ruby -F. -nae 'p $;'
/./

$ cat ip_list.txt | ruby -F'\.' -nae 'p $F'
["192", "30", "252", "153\n"]
```

### **-r _library_ **

ライブラリを `require` するためのオプションです。

```sh
# YAMLを扱う
$ ruby -r 'yaml' -e 'data={name: "Jhon", from: {region: "EURO", country: "ENG"}, age: 28}; puts data.to_yaml()'
---
:name: Jhon
:from:
  :region: EURO
  :country: ENG
:age: 28

$ ruby -r 'yaml' -e 'puts YAML.load(STDIN.read)' <<< '
---
:name: Jhon
:from:
  :region: EURO
  :country: ENG
:age: 28
'
{:name=>"Jhon", :from=>{:region=>"EURO", :country=>"ENG"}, :age=>28}
```

## 暗黙的な`$_`操作

### グローバル関数

`print` `chop` `chomp` `sub` `gsub`
これらのグローバル関数は暗黙的に `$_` を操作し、結果を `$_` に戻します。

```sh
$ cat ip_list.txt
118.151.171.74
54.197.246.21
192.30.252.153

$ cat ip_list.txt | ruby -ne 'print'
$ cat ip_list.txt | ruby -ne 'chop; print'
$ cat ip_list.txt | ruby -ne 'sub(".", "-"); print'
$ cat ip_list.txt | ruby -ne 'gsub(/[12]/, "X"); print'
```

### 正規表現での比較

条件式(if unless etc.)に単独の正規表現リテラルがある場合暗黙のうち`$_`と比較される。

```sh
$ cat ip_list.txt | ruby -ne 'print if /192/'
192.30.252.153

$ cat ip_list.txt | ruby -ne 'print if %r{1.1}'
118.151.171.74
```

## 実践シェルビー芸

### 正規表現で絞り込む

正規表現を使うことで

### Apacheログの解析

特定の時間帯のログだけを絞り込むことを考る。
例えば 2017年1月16日の21時台から2017年1月17日4時台のログを出力する。

```
$ cat access.log | ruby -ne 'print if /16\/Feb\/2017 21/../17\/Feb\/2017 04/'
$ cat access.log | sed -n '/16\/Feb\/2017 21/,/17\/Feb\/2017 04/p'
$ cat access.log | awk '/16\/Feb\/2017 21/,/17\/Feb\/2017 04/'
```

`sed` `awk` のほうが短い・・・。

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


# memo

```
$ cat ip_list.txt | ruby -ne 'chomp' -e 'gsub(/[13]/,"*")' -e 'print' -F'\.' -ae 'puts "\t"+$F[0]'
*92.*0.252.*5*  192
54.*97.246.2* 54
**8.*5*.*7*.74  118

$ ls | head -n 1 | ruby -F123 -nae 'p $;'
/123/
```
