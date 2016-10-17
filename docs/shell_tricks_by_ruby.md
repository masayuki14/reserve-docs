# シェルビー芸

Rubyを使ってシェル芸やってみよう

## 動機

- Ruby使いたいからなんとか使う機会はないものか
- シェルでテキスト処理をする場合にうまくRuby使えないか
- 

## ruby の起動オプション

     -e command     Specifies script from command-line while telling Ruby not to search the rest of the arguments for a script file name.

     -n             Causes Ruby to assume the following loop around your script, which makes it iterate over file name arguments somewhat like sed -n or awk.

                          while gets
                            ...
                          end

     -p             Acts mostly same as -n switch, but print the value of variable $_ at the each end of the loop.  For example:

                          % echo matz | ruby -p -e '$_.tr! "a-z", "A-Z"'
                          MATZ

     -r library     Causes Ruby to load the library using require.  It is useful when using -n or -p.



- `-e` **command** コマンドラインからrubyコードを与える。必須。

- `-n` ループの内側として実行されます。`sed -n` や `awk` のように振る舞います。

- `-p` `-n`オプションと同じように動作し、`$_` を出力します。


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



