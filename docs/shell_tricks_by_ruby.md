# シェルビー芸

Rubyを使ってシェル芸やってみよう

## 動機

- Ruby使いたいからなんとか使う機会はないものか
- シェルでテキスト処理をする場合にうまくRuby使えないか


## ruby の起動オプション

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
```

- `-e` **command** コマンドラインからrubyコードを与える。必須。

- `-n` ループの内側として実行される。`sed -n` や `awk` のように振る舞う。

- `-p` `-n`オプションと同じように動作し、`$_` を出力します。

- `-a` 自動で入力をsplitして$Fにセットする。`-n`や`-p`と使うときのみ有効で`$F = $_.split` をループの戦闘で実行する。

- `-F` splitの区切り文字(`$;`)を指定。

- `-r` **library** プログラムを実行する前に指定されたライブラリをロードする。


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

