# RidePool
シンプルなカーシェリングアプリです。


＊RidePoolアプリはお客さんが無料でどこからどこまである時間に一緒に車やバイクなどの乗りサービスを
予約できるというのアプリであります。

そのアプリはIphone８シムレターで開発しているから、他のシムレターで使うとちょっと
UI順番がバラバラになる可能性もあります。
開発はあぷりがわ側とサーバ側で分けれております。
アプリを適当に動くために、まずサーバの設定が必要になります。
	1.ローカルにSQLデータっベース(名前：ridePool)を作り、テーブル名前（USER＿DATA）とテーブルデータを初期することが必要になります。
			＋テーブルデータ＋
				Id : 自動的増加
				Name: VARCHAR
				Email : VARCHAR
				Password : VARCHAR
	2.『server_side』フォルダにあるPHPファイルはローカルの『htdocs』に貼り付けてください。
	3.次は、『RidePool』フォルダにある『RegisterViewController.swift』と『LoginViewController.swift』の中でNSURL部分にローカルホストのIPアドレスを設定させるになります。

＃アプリ使い方は次の通りです。
	１。まず、アカウント登録が必要になります。
	２。登録とロギンした後、メインのウィンドに小さな虫眼鏡アイコンをクリックして、探索バーとタイムピーカーが出てきます。
		探索バー（乗り場所からと到着場所までで分かれる）
		タイムピーカー（いつに乗りたいタイム）
		リクエストボタン（リクエストをサーバーに送る「予定」）
	３。メインウィンドの左上側にある「Request」ボタンは乗りリクエストを表示させています。クリックすると、確認ウィンドが出てきます。
	４。右上にある『Ride』ボタンは他の人が自分のリクエストをアクセプトした予約を表示させています。

