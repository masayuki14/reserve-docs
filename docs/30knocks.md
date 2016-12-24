# SoftwareDesign 2017.01 shell 30 knocks.

## Q1 Catch

`.exe` という拡張子を持つファイルを抜き出す。

```sh
$ grep -R '\.exe$' files.txt
$ awk '/\.exe$/' files.txt
$ cat files.txt | ruby -ne 'print if /\.exe$/'
```

`\.exe$` を使うのがポイント
files.txt https://github.com/ryuichiueda/ShellGeiData/blob/master/sd201703/files.txt http://bit.ly/2iqCqdd
