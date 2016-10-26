# ECMAScript とは何か

## ECMAScript とは
- ECMA International によって策定されている
- Javascript が準拠している標準仕様
- 2015年6月に公開された
- http://www.ecma-international.org/publications/standards/Ecma-262.htm
- ECMAScript準拠言語
    - Javascript
    - ActionScript (Adobe Flash)
    - UnityScript　など

## ES6の特徴

- モジュール、クラスの標準サポート
    - いままではNodeまわりのモジュールが頑張っていた
- 簡潔な文法の追加
    - アロー関数
    - ブロックスコープ
    - テンプレートリテラル　など
- 後方互換
    - ES6対応環境でも従来のコードが動作するように設計されている

## ES6の新機能!!

|機能|説明|
| --- | --- |
| クラス | クラス定義と継承 |
| モジュール | モジュール定義と読込 |
| アロー関数 | 関数定義の省略記法 |
| オブジェクトリテラル | オブジェクト定義方法の拡張 |
| ブロックスコープ | let と const によるブロックスコープ変数の定義 |
| デフォルトパラメータ | 関数引数にデフォルト値を定義 |
| テンプレートリテラル | 変数の埋め込みや複数行に対応した文字列リテラル |
| イテレータ | 反復処理の統一インタフェース |
| Generator | 停止・再開が出来る特殊な関数 |
| Map, Set | 基本データ構造のための新しいクラス |
| Promise | 非同期処理の統一インタフェース |
| Symbol | ユニークな値を表す新しいプリミティブ |
| Proxy | オブジェクトの操作をカスタマイズ |
| |and more... |

- [lukehoban/es6features(github)](https://github.com/lukehoban/es6features)
ES6新機能を用いた実装を、実際のコードと共に解説している
- [ES6 対応状況](https://kangax.github.io/compat-table/es6/)
- リテラル: 特定のデータ型による値を直接表記する際の書式
    - `new RegExp('ab+c', 'i')`
   - `/ab+c/i`

## コードサンプル

```javascript
// モジュールインポート
import _ from "underscore";
import $ from "jquery";

// クラス定義
class Counter {
    // デフォルトパラメータ
    constructor(selector = 'button') {
        this.count = 0;
        var elements = document.querySelectorAll(selector);
        _.chain(elements)
            // アロー関数
            .each(() => {
                $(el).on("click", () => this.count++);
            });
    }

    output() {
        // テンプレートリテラル
        console.log( `count: ${this.count}`);
    }
}
// モジュールエクスポート
export default Counter;
```

## ES6 を使ってみよう

トランスパイラ *Babel* を使ってES6を使うことができる

```sh
$ npm install -g babel
$ babel es6sample.js > es5sample.js
```

## ES5に変換すると

```javascript
// モジュールインポート
"use strict";

Object.defineProperty(exports, "__esModule", {
    value: true
});

var _createClass = (function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props
[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable
= true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoPro
ps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; };
 })();

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a fu
nction"); } }

var _underscore = require("underscore");

var _underscore2 = _interopRequireDefault(_underscore);

var _jquery = require("jquery");

var _jquery2 = _interopRequireDefault(_jquery);

// クラス定義

var Counter = (function () {
    // デフォルトパラメータ

    function Counter() {
        var _this = this;

        var selector = arguments.length <= 0 || arguments[0] === undefined ? 'button' : arguments[0];

        _classCallCheck(this, Counter);

        this.count = 0;
        var elements = document.querySelectorAll(selector);
        _underscore2["default"].chain(elements)
        // アロー関数
        .each(function () {
            (0, _jquery2["default"])(el).on("click", function () {
                return _this.count++;
            });
        });
    }

    // モジュールエクスポート

    _createClass(Counter, [{
        key: "output",
        value: function output() {
            // テンプレートリテラル
            console.log("count: " + this.count);
        }
    }]);

    return Counter;
})();

exports["default"] = Counter;
module.exports = exports["default"];
```

# モダンになった文法

## アロー関数

- `function` キーワードを使わずに書ける
- ブロックの`{}` と `return` を省略できる
- 引数1つなら `()` を省略できる
- 関数型で書く時効果的

```javascript
// ES5
var add = function(a, b) {
    return a + b;
};

// ES6
var add = (a, b) => {
    return a + b;
}
var add2 = (a, b) => a + b;

[1,2,3,4].filter(n => n % 2 == 0).map(n => n * n);
// => [4, 16]
```

## this の捕捉
 - アロー関数は `this` を捕捉する
 - `bind()` での束縛や `var self = this` の保存は不要

```javascript
// ES5
var mokky = {
    name: 'mokky',
    hello: function() {
        var self = this;         
        setTimeout(function() {
            //ここでの this は mokky  ではない
            console.log( "Hello, my name is " + self.name);
        }, 1000);
    }
}

// ES6
var mokky = {
    name: 'mokky',
    hello: function() {
        setTimeout(() => {
            //ここでの this そのまま
            console.log( "Hello, my name is " + this.name);
        }, 1000);
    }
}
```

## クラス定義
- 標準サポートされました
- public, private はありません

```javascript
class Person {
    // コンストラクタ
    constructor(name) {
        this.name = name;
    }

    // インスタンスメソッド
    greet() {
        console.log("Hello , I'm " + this.name);
    }

    // スタティックメソッド
    static create(name) {
        return new Person(name);
    }
}
```

## クラスの継承

- `extends` キーワードでの継承
- 親クラスへは `super` でアクセス

```javascript
class Author extends Person {
    // コンストラクタ
    constructor(name, book) {
        super(name);
        this.book = book;
    }

    // インスタンスメソッドのオーバーライド
    greet() {
        super.greet();
        console.log("I wrote " + this.book);
    }

    // スタティックメソッドのオーバーライド
    static create(name, book) {
        return new Author(name, book);
    }
}
```

## 組み込みクラスの継承
- ErrorやArrayを継承した独自クラスが定義できる

## ブロックスコープ
- `let` によるブロックスコープ変数
- `const`によるブロックスコープ定数

```javascript
// ES5よくある間違い
for (var i = 0; i < 5; i++) {
    setTimeout(function() { console.log(i) }, i * 1000);
}

// 即時実行しましょう
for (var i = 0; i < 5; i++) {
    (function(x) {
        setTimeout(function() { console.log(x) }, x * 1000);
    }(i);
}

// ES6 letを使うと
for (let i = 0; i < 5; i++) {
    // i は書くループ（ブロックスコープ）ごとに保持される
    setTimeout(function() { console.log(i) }, i * 1000);
}

// const  定数
const foo = 1;
foo = 2; // エラー 再代入禁止!!
const obj;
obj.foo = 1; // 変更は可能
```

## デフォルトパラメータ

```javascript
function (a = 1, b = 2) {
    return a + b;
}

// ES5 のやり方
function (a, b) {
    a = (a === undefined) ? 1 : a;
    b = (b === undefined) ? 2 : b;
    return a + b;
}
```

## イテレータ
- for/of 文
- IterableインタフェースとIterator

```javascript
// ES5
var arr = [1, 2, 3, 4, 5];
for (var i = 0; i < arr.length; i++) {
    console.log( i );
}

// ES6 for/of
for (let n of arr) {
    console.log( n );
}

// Iterable
var chars = [];
for (let n of "Hello") {
    chars.push(n);
}
console.log(chars);  // => ["H", "e", "l", "l", "o"];
```

## テンプレートリテラル
- 変数の埋め込み
    - バッククォートと `${}`
- 複数行文字列

```javascript
var name = "Terry";
console.log(`Hello, ${name}.`);
console.log(` 1 + 1 = ${1 + 1}`);

var text = `
line 1
line 2
line 3
`;
```

# 強化された標準ライブラリ

## Map 
- key-value 型のデータを扱う専用クラス
- keyの同一性は `===` で判定
- オブジェクトをkeyとして利用できる

```javascript
// 基本的な使い方
vat map = new Map();
map.set("key1", "value1");
map.get("key1"); // "value1"
map.has("key1"); // true
map.delete("key1");
map.has("key1"); // false

var key3 = {};
var key4 = {};
map.set(key3, "v3");
map.set(key4, "v4");
map.get(key3); // "v3"

// 一括設定
var map2 = new Map([["k1", "v1"], ["k2", "v2"]]);

// Iterable
for (let [k, v] of map2) {
    console.log(k ,v); // "k1" "v1", // "k2" "v2"
}

console.log(map.size); // 2
map2.clear();
console.log(map.size); // 0
```

## Set
- 重複のないユニークな値の集合
- 同一性は `===` で判定
- メソッドの多くは `Map` と互換

```javascript
// 基本的な使い方
var set = new Set();
set.add("value1");
set.has("value1"); // true

// 重複は追加されない
console.log(set.size); // 1
set.add("value1");
console.log(set.size); // 1

set.delete("value1");
set.has("value1"); // false

// 一括設定
var set2 = new Set(["v1", "v2", "v3"]);
console.log(set2.size); // 3
set2.clear();
console.log(set2.size); // 0

// Iterable
for (let v of set2) {
    console.log(v); // "v1", // "v2", // "v3"
}
```

##  Symbol, Proxy
- Symbol
    - 新しいプリミティブ型
    - `Symbol()` で生成
    - ユニークな値で同値比較が `false` になる
- Proxy
    - オブジェクトや関数をラップする仕組み
    - 定義されていないプロパティを動的に生成することも可能
    - 柔軟なメタプログラミングができる

## String, Array, Object, Math, RegExp
- 既存クラスが拡張されている
- 新メソッドの追加
- String, RegExp の unicode対応


# 簡潔な非同期処理

## Promise

- 従来の非同期処理はコールバックのネストがひどい
- エラー処理が分散
- コードが醜い
- Promiseで解決!!

```javascript
function getFirstItem(callback) {
    // アイテムリスト取得
    getUrl('/api/items', function (err, items) {
        // 最初のエラー処理
        if (err) {
            return callback(err);
        }
        // 先頭アイテム取得
        getUrl('/api/item/' + items[0].id, function (err, detail) {
            // 2つ目のエラー処理
            if (err) {
                return callback(err);
            }
            // 成功
            callback(null, detail);
        });
    });
}

// 本体から呼び出し
getFirstItem(function(err, item) {
    if (err) {
        // エラー処理
        console.error(err);
    }

    // 本来やりたい処理
    doSomeProcess(item);
});
```

## Promiseで解決

- `then()` メソッドで正常系
- `catch()` メソッドで異常系
- エラーハンドリングが一箇所に集約

```javascript
function getFirstItem() {
    return getUrl("/api/items").then( function(items) {
        return getUrl("/api/item" + items[0].id);
    });
}

// 本体から呼び出し
getFirstItem().then(function(item) {
    doSomeProcess(item);
}).catch(function(err) {
    // エラー処理
    console.error(err);
});
```

## Promise Sample (whatwg-fetch)

```javascript
class Sapmle {

  _loadAccounts() {
    fetch('/api/sim/items')
      .then((response) => {
        return response.json();
      })
      .then((json) => {
        this.setState({
          accounts: json
        });
      }.bind(this))
      .catch((ex) => {
        //alert('データの読み込みに失敗しました');
      });
  }

}
```

## Generator

- 停止したり再開したりできる特殊な関数
- `yeild` でをつかう


わからん

# モジュール管理

## 特徴
- 宣言的でシンプルなインポート・エクスポートの仕組み
- 読み込み方法は同期・非同期に対応
- トップレベルでの宣言（if 文や関数内はエラー）
- 宣言の巻き上げ

## 名前付きエクスポート
- 名前を知っていないといけない

```javascript
// module.js
export var foo = 'foo';
export function bar() {};
export class Baz() {
    baz() {}
}
```

```javascript
// メンバーごとにインポート
import {foo, bar, baz} from './module.js';
console.log('foo'); // 'foo'
bar();
new Baz()

// インポートする変数名の指定
import {foo as poo} from './module.js';
console.log(poo); // 'foo'

//  まとめてインポート
import * as module from './module.js';
console.log(module.foo); // 'foo'
```

## デフォルトエクスポート
- モジュール1つに対し1つのメンバに限り無名でインポートできる

```javascript
// foo.js
export default 'foo';
// bar.js
export default function() {
    console.log('bar');
};
// baz.js
export default class {
    constructor() {
        console.log('Baz!');
    }
}
```

```javascript
import a from './foo.js';
import b from './bar.js';
import c from './baz.js';

console.log(a); // 'foo'
b(); // 'bar'
new c(); // 'Baz!'
```
