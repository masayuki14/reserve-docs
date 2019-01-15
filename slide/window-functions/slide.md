# 君はWindow関数を知っているか！？

subtitle
:   テクテクテック#7 DB勉強会

date
:   2019/01/16

author
:   @masayuki14

theme
:   clear-blue

allotted-time
:   20m

set_background("red")

# 目次

- 自己紹介
- Window関数とは
- 実践Window関数
- まとめ


# 自己紹介

- もりさきまさゆき

- @masayuki14

![](icons.png){: relative_width='60' align='left'}


{:.center}
**Follow me !!**


## プロパティ

background-image
:   icon.jpg

background-image-relative-width
:   30

background-image-align
:   right

background-image-relative-margin-right
:   3

background-image-opacity
:   0.5

# 自己紹介

- プロ主夫
    - 妻1人 {::note} (フルタイム) {:/note} 幼児2人
    - フリーランス {::note} (Web系パートタイム) {:/note}
    - データベーススペシャリスト

- コミュニティ
    - はんなりPython {::note} (第3金曜開催@京都) {:/note}
    - OSS Gate {::note} (京都, 大阪, 東京) {:/note}

- スプーキーズアンバサダー

# スプーキーズ@京都

- Web系システム
- ソーシャルゲーム開発
- ボードゲーム制作

{:.center}
**Webエンジニア積極採用中！！**

## プロパティ

background-image
:   spookies_logo.png

background-image-relative-width
:   30

background-image-align
:   right

background-image-relative-margin-right
:   3

{::comment}
{:/comment}


# スプーキーズ@京都

勉強会 [テクテクテック](https://goo.gl/hXXafu)

- 2019/03 予定
    - 1周年記念パーティ
- もくもく会はじめました
    - 平日 19:00〜
    - いつでも来てね!!

## プロパティ

background-image
:   spookies_logo.png

background-image-relative-width
:   30

background-image-align
:   right

background-image-relative-margin-right
:   3

{::comment}
{:/comment}


# Window関数とは

{::tag name="x-large"} Window関数とは {:/tag}

# Window関数とは

{::tag name="x-large"} Window + 関数 ??  {:/tag}

# Window関数とは

{::tag name="large"} Window の意味は？ {:/tag}
:   - {::tag name="x-large"}×  窓 {:/tag}
    - {::tag name="x-large"}○  範囲 幅 {:/tag}

# Window関数とは

{::tag name="large"} 範囲を指定して {:/tag}
:   - {::tag name="large"} 違う行を自分の行にもってくる {:/tag}
    - {::tag name="large"} 集約結果を自分の行にもってくる {:/tag}

# Window関数とは

{::tag name="x-large"} どうやって範囲を指定する？ {:/tag}

# Window関数とは

{::tag name="x-large"} Window関数を使って {:/tag}

# Window関数とは

{::tag name="x-large"} SQLを見てみよう {:/tag}

# Window関数とは

Window関数を使ったSQLの例

```
SELECT
    customer_id,
    amount,
    RANK() OVER (
        PARTITION BY customer_id
        ORDER BY amount DESC) AS rk
FROM payment;
```
{: lang="sql" }

# Window関数とは

実はこれの省略形(名前付き構文)

```
SELECT
    customer_id,
    amount,
    RANK() OVER w AS rk
FROM payment
WINDOW w AS (PARTITION BY customer_id
             ORDER BY amount DESC);
```
{: lang="sql" }

# Window関数とは

Windowの使い回し

```
SELECT
    customer_id,
    amount,
    RANK()       OVER w AS rk,
    MAX(amount)  OVER w AS max
FROM payment
WINDOW w AS (PARTITION BY customer_id
             ORDER BY amount DESC);
```
{: lang="sql" }

# Window関数とは

Window関数の書き方

```
SELECT
    集約関数() OVER (範囲指定)
FROM table
```
{: lang="sql" }

`OVER()` があればWindow関数

# Window関数とは

Window関数の書き方

集約関数
:   - ROW_NUMBER(), FIRST_VALUE()
    - MAX(), MIN(), AVG()

範囲指定
:   - PARTITION BY, ORDER BY
    - フレーム句

# Window関数とは

![](window_func.png){: relative_width='100' }

{:.center}
> {::tag name="xx-small"} 1枚でわかるWindow関数 - https://codezine.jp/article/detail/11115 {:/tag}

# Window関数とは

Window関数の3つの機能

- PARTITION BY 句によるレコード集合の分割
- ORDER BY 句によるレコードの順序づけ
- フレーム句によるカレントレコードを中心としたサブセット定義

# 実践Window関数

{::tag name="x-large"} 実践Window関数 {:/tag}

# 実践Window関数

{::tag name="x-large"} まずはPARTITION BY を {:/tag}
{::tag name="x-large"} おさえよう {:/tag}

# 実践Window関数

```
+-----------+------+------+
| member    | team | age  |
+-----------+------+------+
| 富士崎    | A    |   39 |
| 西塚      | A    |   45 |
| 西崎      | A    |   24 |
| 逸見      | B    |   26 |
| 岡村      | B    |   18 |
| 東野      | C    |   50 |
| 各務原    | D    |   27 |
| 犬山      | D    |   28 |
| 鳥羽      | D    |   33 |
| 桃山      | D    |   28 |
+-----------+------+------+
```

# 実践Window関数

{::tag name="xx-small"} team ごとに分割して行番号を取得する {:/tag}

```
SELECT
    member,
    team,
    age,
    ROW_NUMBER() OVER (
        PARTITION BY team
        ORDER BY age) AS num
FROM teams;
```
{: lang="sql" }


# 実践Window関数

{::tag name="xx-small"} team ごとに分割して行番号を取得する {:/tag}

```
+-----------+------+------+-----+
| member    | team | age  | num |
+-----------+------+------+-----+
| 西崎      | A    |   24 |   1 |
| 富士崎    | A    |   39 |   2 |
| 西塚      | A    |   45 |   3 |
| 岡村      | B    |   18 |   1 |
| 逸見      | B    |   26 |   2 |
| 東野      | C    |   50 |   1 |
| 各務原    | D    |   27 |   1 |
| 桃山      | D    |   28 |   2 |
| 犬山      | D    |   28 |   3 |
| 鳥羽      | D    |   33 |   4 |
+-----------+------+------+-----+
```

# 実践Window関数

{::tag name="xx-small"} team ごとに分割して順位を取得する {:/tag}

```
SELECT
    member,
    team,
    age,
    RANK() OVER (
        PARTITION BY team
        ORDER BY age) AS rk
FROM teams;
```
{: lang="sql" }


# 実践Window関数

{::tag name="xx-small"} team ごとに分割して順位を取得する {:/tag}

```
+-----------+------+------+----+
| member    | team | age  | rk |
+-----------+------+------+----+
| 西崎      | A    |   24 |  1 |
| 富士崎    | A    |   39 |  2 |
| 西塚      | A    |   45 |  3 |
| 岡村      | B    |   18 |  1 |
| 逸見      | B    |   26 |  2 |
| 東野      | C    |   50 |  1 |
| 各務原    | D    |   27 |  1 |
| 犬山      | D    |   28 |  2 |
| 桃山      | D    |   28 |  2 |
| 鳥羽      | D    |   33 |  4 |
+-----------+------+------+----+
```

# 実践Window関数

![](partition.png){: relative_width='100' }

# 実践Window関数


# 実践Window関数


# 実践Window関数

# 実践Window関数

# 実践Window関数

# 実践Window関数
