


import 'app_localizations.dart';

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get app_name => 'FocusFish';

  @override
  String get enter_app => 'アプリを起動します';

  @override
  String get loading_text => '読み込み中...';

  @override
  String get company_info => 'Copyright © 2022 FocusFish. All Rights Reserved.';

  @override
  String get init_data_failed => 'データの初期化に失敗しました。ネットワーク接続が正常かどうかを確認し、アプリケーションを再起動してください';

  @override
  String get tips => 'ヒント';

  @override
  String get confirm => 'はい';

  @override
  String get cancel => 'キャンセル';

  @override
  String get skip => 'をスキップ';

  @override
  String get start => 'スタート';

  @override
  String get data_parse_exception => 'データ解析エラー';

  @override
  String get connect_exception => 'ネットワークの接続を確認するか、後でもう一度実行してください。';

  @override
  String get socket_time_out_exception => 'ネットワーク接続がタイムアウトしました、接続の状態を確認してください。';

  @override
  String get unknown_host_exception => 'ネットワークの接続を確認するか、後でもう一度実行してください。';

  @override
  String get server_error => 'サーバーにエラーが発生しました。';

  @override
  String get network_address_not_exist => 'リクエストアドレスが存在しません。';

  @override
  String get request_rejected => 'サーバーが要求を拒否しました。';

  @override
  String get request_redirected => '他のページにリダイレクトします。';

  @override
  String get unauthorized => 'アクセス権限がありません。';

  @override
  String get invalid_request => 'リクエストが無効です';

  @override
  String get wrong_phone_num => '電話番号エラー';

  @override
  String get user_not_exist => 'アカウントは登録されていません';

  @override
  String get wrong_psw => '間違ったパスワード';

  @override
  String get login => 'ログイン';

  @override
  String get login_with_phone_number => '電話番号でログインする';

  @override
  String get phone_number => '携帯電話番号';

  @override
  String get input_password => 'パスワードを入力してください';

  @override
  String get register_an_account => 'アカウントをお持ちでないでしょうか?';

  @override
  String get sign_up_immediately => '今すぐ登録';

  @override
  String get forgot_password => 'パスワードを忘れた?';

  @override
  String get choose_country => '国または地域を選択してください';

  @override
  String get search => '検索';
}
