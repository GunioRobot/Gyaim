# Gyaim

 * [MacRuby](http://www.macruby.org/)で作ったMac用のIMEです。
 * 数百行のRubyで実用レベルのIMEを作れることを示すものです
    * 単純な変換しかできませんがそれなりに使えます
    * 見栄えはInterfaceBuilderで簡単に変更できます
    * 変換アルゴリズムやIMEの動作はRubyで簡単に変更できます
    * 自前のIMEをいろいろ作りましょう!
 * 現在の変換部分は超いい加減です
    * 予測機能がありません

<!--
    * そのかわり(?)パタンに正規表現が使えます
        * "ke.*da" と入力すると "慶應大" が候補に出たり
-->

## インストール

 * [MacRuby](http://www.macruby.org/)のインストールが必要です
 * 多分SnowLeopardが必要です
 * コンパイルは↓で
    * $ mkdir ~/.gyaimdict
    * $ touch ~/.gyaimdict/dict2d
    * $ make small または $ make large
 * その後、ログアウトして再ログインすると
   「言語環境設定」からGyaimを選択できるようになります
 * PalmのIMEで利用してた「富豪辞書」を使っています
    * 自前の適当な辞書を使うことも可能です

## 使いかた

 * ローマ字を入力すると候補が表示されます
 * スペースキーで候補を選択し、改行キーで確定します
 * ローマ字入力の後ですぐ改行キーを押すと完全マッチで候補が検索されます
    * ひらがな、カタカナ入力に便利です
 * ローマ字入力した後「.」を入力するとGoogleSuggestが呼ばれます
    * 固有名詞の入力に便利です
    * "ottoga." などと入力するとひどいことになります
 * 単語登録
    - 登録したい単語をドラッグして選択した後で文字入力すると、選択した単語が第一候補に表示され、
      その単語をスペースキーで選択して改行キーで確定するとユーザ辞書に登録されます
 * ユーザ辞書、学習辞書は以下にセーブされます
    - ユーザ辞書: ~/.gyaimdict/localdict.txt
    - 学習辞書: ~/.gyaimdict/studydict.txt
    - ユーザ辞書は普通に編集可能です

## 秘密文字列の入力

 * クレジットカード番号のように、
   辞書に登録はできないけれどもしばしば入力が必要な秘密文字列を簡単に入力することができます
 * 秘密の読みを入力した後で「?」を入力すると秘密文字列が候補に表示されます
 * 前述の単語登録のやり方を使用して、文字列の最後に「?」が続くような読みを登録すると
   暗号化された文字列が辞書に登録されます
 * たとえばクレジットカード番号を「kureka?」という読みで登録しておくと、
   「kureka?」と入力したときクレジットカード番号が候補に表示されます
 * 「kureka」だと他人にわかってしまうかもしれませんが、
   秘密の読みを利用すれば、それを入力しない限りクレジットカード番号が候補に出ることはありませんし、
   辞書には暗号化された文字列だけが登録されるので安全です
   (「kureka」のような読みは辞書に登録されません)
 * 例えば「32文字のパスワードを要求する鬼畜なシステム」が有ったとしても、
   この方式で登録しておけば覚えておく必要がなくなります
 * 何かの理由で秘密ファイルを使う必要があるとき、
   秘密ファイルの名前を登録しておけば見失ってしまうことがありません

## TODO

 * 様々な変換エンジンを切り替える
 * Romakana.rbをRuby1.9用に修正
 * 辞書キャッシュの扱い
    - Resourceに入れる
    - make dictでキャッシュをResource内に作る
        - Marshalを利用するのをやめる
 * 登録を簡単にしたい
    - 研究になるかも?
 * 単漢字変換
  - 候補が10個以上出るように
 * 予測機能
    - 実は要らないかも
 * SocialIMEとかGoogleIMEとかを呼ぶ
 * まともな変換システムを自力で作る
 * 現在のテキストを変換に利用する
   - IMEが使うNSTextは読むことができると思うので

## 言及など

 * http://d.hatena.ne.jp/nokuno/20110406

<!--

## 論文ネタ

 * IME用のヒントを与えるアプリケーション
        <input type="text" hint="kamakura_address">
   みたいにすると鎌倉の住所を入力しやすいIMEが出てくる
 * ヒントを出すだけだと既に色々あるかも
 * ヒントによって画像すら入れられるようにすると凄い
 * MacのIMEで画像を入力できる気がする
    - NSTextViewじゃなくてWebView(?)にすればよい
-->
