

# RidePool
RidePoolアプリはお客さんが無料でどこからどこまである時間に一緒に車やバイクなどの乗りサービスを
予約できるというのアプリであります。

## 使い方
1.そのアプリはIphone８シムレターで開発しているから、他のシムレターで使うとちょっとUI順番がバラバラになる可能性もあります。

2.開発はあぷりがわ側とサーバ側で分けれております。

3.アプリを適当に動くために、まずサーバの設定が必要になります。
  1. ローカルにSQLデータっベース(名前：ridePool)を作り、テーブル名前（USER＿DATA）とテーブルデータを初期することが必要になります。
  
Id            | Name          | Email         | Password      
------------- | ------------- | ------------- | -------------
1             | etc           | etc           | etc         
2             | etc           | etc           | etc         


  2. 『server_side』フォルダにあるPHPファイルはローカルの『htdocs』に貼り付けてください。
  3. 次は、『RidePool』フォルダにある『RegisterViewController.swift』と『LoginViewController.swift』の中NSURL部分にローカルホストのIPアドレスを設定させるになります。
 
4. アプリ使い方は次の通りです。
    1. まず、アカウント登録が必要になります。
    2. 登録とロギンした後、メインのウィンドに小さな虫眼鏡アイコンをクリックして、探索バーとタイムピーカーが出てきます。
      1. 探索バー（乗り場所からと到着場所までで分かれる）
## History
TODO: Write history
## Credits
TODO: Write credits
## License
TODO: Write license
]]
