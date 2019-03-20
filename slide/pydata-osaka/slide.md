# Dockerを使った可視化環境の作り方

subtitle
:   はんなりPython+PyData Osakaの可視化特集

date
:   2019/03/24

author
:   @masayuki14

theme
:   blue-bar

allotted-time
:   20m

# 自己紹介

- もりさきまさゆき(Masa)

- @masayuki14

![](../assets/services.png){: relative_width='60' relative_margin_top='25'}


{:.center}
**Follow me !!**


## プロパティ

background-image
:   ../assets/icon.jpg

background-image-relative-width
:   30

background-image-align
:   right

background-image-relative-margin-right
:   3

background-image-relative-margin-top
:   3

background-image-opacity
:   0.5

# 自己紹介

- プロ主夫
    - フリーランス {::note} (Web系パートタイム) {:/note}
    - データベーススペシャリスト

- コミュニティ
    - はんなりPython {::note} (第3金曜開催@京都) {:/note}
    - OSS Gate {::note} (京都, 大阪, 東京) {:/note}

- スプーキーズアンバサダー

# スプーキーズ@京都

- ボードゲーム制作
- Web系システム
- ソーシャルゲーム開発

{:.center}
**Webエンジニア積極採用中！！**

## プロパティ

background-image
:   ../assets/spookies_logo.png

background-image-relative-width
:   30

background-image-align
:   right

background-image-relative-margin-right
:   3

{::comment}
{:/comment}


# スプーキーズ@京都


もくもく会 [モクモクモック](https://spookies.connpass.com/event/123996/)

- 2019/03/28
    - モクモクモック（末木会）#6

勉強会 [テクテクテック](https://goo.gl/hXXafu)

- 2019/04/10
    - テクテクテック #8 サーバ監視や負荷テストどうやってるの？

## プロパティ

background-image
:   ../assets/spookies_logo.png

background-image-relative-width
:   30

background-image-align
:   right

background-image-relative-margin-right
:   3

{::comment}
{:/comment}


# Dockerを使った可視化環境の作り方

# Dockerを使った可視化環境の作り方

- 可視化アプリをつくろう!!
- 困ったことがたくさん
- できることから少しずつ
- Dockerで開発環境ができてた


# 可視化アプリを作ろう！

- ハンズオンでDash
- 簡単にできそう
- 興味のあるデータがない
- 懇親会でわいわい
- アイデアが降りてきた

# 遊園地の待ち時間を可視化しよう！

# USJ！TDL！TDS！

# 可視化アプリを作ろう！

\\n
というわけで
待ち時間可視化アプリの
開発を始めるが・・・。

# Python 難しい

# Python 難しいというか

# 困ったこと多すぎ

# 困ったこがたくさん

- Python慣れてない
    - やりたいことがすぐできないストレス
    - ライブラリ知らない
    - 書きながら動かしたい
- 環境どうしよう
    - Dashを動かすには
    - pyenv venv わからん
    - PC汚したくない

# 困ったこがたくさん

- Pandas慣れてない
    - CSVはあるけど目的の形にできない
    - データ操作のストレスが爆発
    - 処理が重い
    - データだけみたい時こまる

# 困ったこがたくさん

- PC2台
    - デスクトップ
    - ラップトップ
    - 環境揃えたい

# なんとかならんか

# こつこつやるしかない

# できることから少しずつ

環境どうしよう
:   - **Docker使おう！**
    - 使い捨てでいいや
    - とりあえず動くもの
    - バージョンとか気にしなくていい

