この記事はVue.jsアドベントカレンダー12月14日の記事です。

Vuexのはじめかた。

Vuexはflaxアーキテクチャを採用した公式プラグインで、vue.jsで利用することができます。
公式の日本語ドキュメントもあるので導入しやすい状況になっています。

とはいえ、いざ使ってみようという時には、なかなか気が引けてしまうもの。
自分が導入を試みた時も、いろいろと悩むポイントがありました。

どこから手をつけていいかわからない
ファイル構成のお手本が知りたい
スタンダードな書き方を知りたい

このあたりのことを、どう解決したかについて今回は紹介します。


#はじめにすること

ドキュメント読もう。なかなか苦手な人もいるけどがんばれ。
**なにを意識しながら読むか**が決まっていれば読みやすいでしょう。

## fluxを理解する

事前にFluxアーキテクチャについて知っておくと良いでしょう。
fluxアーキテクチャについて理解する必要があります。fluxを知った上でVuexのドキュメントを読むとより理解しやすくなります。

アーキテクチャの構成要素と一方向性の特徴がつかめればいい。

https://qiita.com/knhr__/items/5fec7571dab80e2dcd92
http://post.simplie.jp/posts/36

https://github.com/facebook/flux
雑誌があればそれが一番わかりやすいです。
https://www.google.co.jp/amp/gihyo.jp/amp/magazine/wdpress/archive/2017/vol97

## まずは公式ドキュメント

https://vuex.vuejs.org/ja/intro.html

事前に公式ドキュメントを一通り読んで起きましょう。流し読みでよいです。
**コアコンセプト**に具体的な実装方法が記載されているので、これを中心に読むと良いでしょう。
初めての時は、書き方を覚えることもできないし、ぼんやりとしか理解できないと思います。
でもそれでOKです。
全体として何が出来るのかをつかむことが重要です。

- Vuex とは何か？
- Vuex 入門
- コアコンセプト

の3つの章を読めばとりあえずは大丈夫でしょう。


# 小さく始めよう

コアコンセプトにある5つの要素をいきなり全て取り入れることは、初心者にとっては困難なことです。
そうなった時には、何から手を付けていいかわからない、という状況に陥ります。
なので、小さく始めて少しずつVuexを取り入れていきましょう。

サンプルコードは `$ vue init webpack sample` で作成されたプロジェクトを基に進めていきます。

## まずはステートから

まずはステートの導入から初めましょう。以下のような何でもない Sample.vue を例にします。

```components/Sample.vue
<template>
  <div class="sample">
    <h1>{{ msg }}</h1>
  </div>
</template>

<script>
export default {
  name: 'sample',
  data() {
    return {
      msg: 'Welcome to My Vuex Sample',
    };
  },
};
</script>
```

### Vuex ストアを作成

`msg` プロパティを表示するだけのシンプルなコンポーネントです。この `msg` プロパティを `Vuex` に移していきます。
まず、Vuexストアを作成しVueに入れます。

```main.js
import Vuex from 'vuex';
Vue.use(Vuex);

const store = new Vuex.Store({
  state: {
    msg: 'Hello Vuex Store.',
  },
});

new Vue({
  el: '#app',
  router,
  template: '<App/>',
  components: { App },
  store,
});
```

これでVuexを使う準備が整いました。


### コンポーネントから Vuex ストアを参照する

次はVuexストアから `msg` ステートを読み込んで `Sample.vue` に表示しましょう。
コンピューテッドプロパティからストアを参照するように変更します。

```Sample.vue
export default {
  name: 'sample',
  data() {
    return {
      // msg: 'Welcome to My Vuex Sample.',
    };
  },

  computed: {
    msg() {
      return this.$store.state.msg;
    },
  },
};
```

**Hello Vuex Store.** が表示されましたね！おめでとう！

### mapState ヘルパーを使う

msgのようなステートを複数読み込む場合には `mapState` ヘルパーを使うことで簡潔に記述することができます。

```Sample.vue
import { mapState } from 'vuex';

export default {
  name: 'sample',
  data() {
    return {
    };
  },

  computed: {
    ...mapState({
      msg: state => state.msg,
    }),
  },
};
```

`msg` の長さを取得するコンピューテッドプロパティを定義したい場合にもローカルステートのようにthisでアクセスできます。

```Sample.vue
computed: {
  msgLength() {
    return this.msg.length;
  },
  ...mapState({
    msg: state => state.msg,
  }),
},
```

これでVuexのステートを利用することが出来るようになりました。

## ステートの値を変更するには

ステートの `msg` を更新するにはどうしたら良いでしょうか。更新ボタンをクリックすると、フォームの入力値でステートを更新するようにします。

```Sample.vue
<input type="text" v-model="newMsg" />
<button @click="update">更新</button>

export default {
  name: 'sample',
  data() {
    return {
      newMsg: null,
    };
  },

  methods: {
    update() {
      this.$store.state.msg = this.newMsg;
    },
  },
};
```

`update()` メソッドで `msg` を `newMsg` に入力された値に更新します。
しかしこの方法だとアプリケーションが大きくなるにつれ、どこで `msg` が更新されるかが追いづらくなります。
そこでミューテーションの出番です。

## ミューテーションを定義する

Vuex のストアの状態を変更できる唯一の方法は、ミューテーションをコミットすることです。


