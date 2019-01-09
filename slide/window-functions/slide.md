# 君はWindow関数を知っているか！？

subtitle
:   第9回 関西DB勉強会

date
:   2019/01/16

author
:   @masayuki14

theme
:   clear-blue

allotted-time
:   20m


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

# Window関数とは

# 実践Window関数

# 実践Window関数

# 実践Window関数

# 実践Window関数

# 実践Window関数

