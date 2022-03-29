
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart' deferred as app_localizations_en;
import 'app_localizations_ja.dart' deferred as app_localizations_ja;
import 'app_localizations_zh.dart' deferred as app_localizations_zh;

/// Callers can lookup localized strings with an instance of AppLocalizations returned
/// by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// localizationDelegates list, and the locales they support in the app's
/// supportedLocales list. For example:
///
/// ```
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
    Locale('zh'),
    Locale('zh', 'CN'),
    Locale('zh', 'HK'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
    Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN', scriptCode: 'Hans'),
    Locale.fromSubtags(languageCode: 'zh', countryCode: 'HK', scriptCode: 'Hans'),
    Locale.fromSubtags(languageCode: 'zh', countryCode: 'MO', scriptCode: 'Hans'),
    Locale.fromSubtags(languageCode: 'zh', countryCode: 'SG', scriptCode: 'Hans'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
    Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN', scriptCode: 'Hant'),
    Locale.fromSubtags(languageCode: 'zh', countryCode: 'HK', scriptCode: 'Hant'),
    Locale.fromSubtags(languageCode: 'zh', countryCode: 'MO', scriptCode: 'Hant'),
    Locale.fromSubtags(languageCode: 'zh', countryCode: 'TW', scriptCode: 'Hant'),
    Locale('zh', 'MO'),
    Locale('zh', 'SG'),
    Locale('zh', 'TW')
  ];

  /// No description provided for @app_name.
  ///
  /// In en, this message translates to:
  /// **'FocusFish'**
  String get app_name;

  /// No description provided for @enter_app.
  ///
  /// In en, this message translates to:
  /// **'Enter App'**
  String get enter_app;

  /// No description provided for @loading_text.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading_text;

  /// No description provided for @company_info.
  ///
  /// In en, this message translates to:
  /// **'Copyright © 2022 FocusFish. All Rights Reserved.'**
  String get company_info;

  /// No description provided for @init_data_failed.
  ///
  /// In en, this message translates to:
  /// **'Initialize data failed, please check your internet connection and restart the app.'**
  String get init_data_failed;

  /// No description provided for @tips.
  ///
  /// In en, this message translates to:
  /// **'Tips'**
  String get tips;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @data_parse_exception.
  ///
  /// In en, this message translates to:
  /// **'Data parsing error'**
  String get data_parse_exception;

  /// No description provided for @connect_exception.
  ///
  /// In en, this message translates to:
  /// **'Network is abnormal, please check your internet connection'**
  String get connect_exception;

  /// No description provided for @socket_time_out_exception.
  ///
  /// In en, this message translates to:
  /// **'Connection time out, please check your internet connection'**
  String get socket_time_out_exception;

  /// No description provided for @unknown_host_exception.
  ///
  /// In en, this message translates to:
  /// **'Network is abnormal, please check your internet connection'**
  String get unknown_host_exception;

  /// No description provided for @server_error.
  ///
  /// In en, this message translates to:
  /// **'Server error'**
  String get server_error;

  /// No description provided for @network_address_not_exist.
  ///
  /// In en, this message translates to:
  /// **'Request address does not exist'**
  String get network_address_not_exist;

  /// No description provided for @request_rejected.
  ///
  /// In en, this message translates to:
  /// **'The request was rejected by the server'**
  String get request_rejected;

  /// No description provided for @request_redirected.
  ///
  /// In en, this message translates to:
  /// **'The request is redirected to another page'**
  String get request_redirected;

  /// No description provided for @unauthorized.
  ///
  /// In en, this message translates to:
  /// **'Unauthorized'**
  String get unauthorized;

  /// No description provided for @invalid_request.
  ///
  /// In en, this message translates to:
  /// **'Invalid request'**
  String get invalid_request;

  /// No description provided for @wrong_phone_num.
  ///
  /// In en, this message translates to:
  /// **'Wrong phone number'**
  String get wrong_phone_num;

  /// No description provided for @user_not_exist.
  ///
  /// In en, this message translates to:
  /// **'This account has not been registered'**
  String get user_not_exist;

  /// No description provided for @wrong_psw.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password'**
  String get wrong_psw;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @login_with_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Log in with phone number'**
  String get login_with_phone_number;

  /// No description provided for @phone_number.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phone_number;

  /// No description provided for @input_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get input_password;

  /// No description provided for @register_an_account.
  ///
  /// In en, this message translates to:
  /// **'Register an account?'**
  String get register_an_account;

  /// No description provided for @sign_up_immediately.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get sign_up_immediately;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgot_password;

  /// No description provided for @choose_country.
  ///
  /// In en, this message translates to:
  /// **'Choose Country/Region'**
  String get choose_country;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return lookupAppLocalizations(locale);
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ja', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

Future<AppLocalizations> lookupAppLocalizations(Locale locale) {
    // Lookup logic when language+script+country codes are specified.
  switch (locale.toString()) {
    case 'zh_Hans_CN': return app_localizations_zh.loadLibrary().then((dynamic _) => app_localizations_zh.AppLocalizationsZhHansCn());
        case 'zh_Hans_HK': return app_localizations_zh.loadLibrary().then((dynamic _) => app_localizations_zh.AppLocalizationsZhHansHk());
        case 'zh_Hans_MO': return app_localizations_zh.loadLibrary().then((dynamic _) => app_localizations_zh.AppLocalizationsZhHansMo());
        case 'zh_Hans_SG': return app_localizations_zh.loadLibrary().then((dynamic _) => app_localizations_zh.AppLocalizationsZhHansSg());
        case 'zh_Hant_CN': return app_localizations_zh.loadLibrary().then((dynamic _) => app_localizations_zh.AppLocalizationsZhHantCn());
        case 'zh_Hant_HK': return app_localizations_zh.loadLibrary().then((dynamic _) => app_localizations_zh.AppLocalizationsZhHantHk());
        case 'zh_Hant_MO': return app_localizations_zh.loadLibrary().then((dynamic _) => app_localizations_zh.AppLocalizationsZhHantMo());
        case 'zh_Hant_TW': return app_localizations_zh.loadLibrary().then((dynamic _) => app_localizations_zh.AppLocalizationsZhHantTw());
  }

  // Lookup logic when language+script codes are specified.
  switch (locale.languageCode) {
    case 'zh': {
  switch (locale.scriptCode) {
    case 'Hans': return app_localizations_zh.loadLibrary().then((dynamic _) => app_localizations_zh.AppLocalizationsZhHans());
case 'Hant': return app_localizations_zh.loadLibrary().then((dynamic _) => app_localizations_zh.AppLocalizationsZhHant());
   }
  break;
   }
  }

  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'zh': {
  switch (locale.countryCode) {
    case 'CN': return app_localizations_zh.loadLibrary().then((dynamic _) => app_localizations_zh.AppLocalizationsZhCn());
case 'HK': return app_localizations_zh.loadLibrary().then((dynamic _) => app_localizations_zh.AppLocalizationsZhHk());
case 'MO': return app_localizations_zh.loadLibrary().then((dynamic _) => app_localizations_zh.AppLocalizationsZhMo());
case 'SG': return app_localizations_zh.loadLibrary().then((dynamic _) => app_localizations_zh.AppLocalizationsZhSg());
case 'TW': return app_localizations_zh.loadLibrary().then((dynamic _) => app_localizations_zh.AppLocalizationsZhTw());
   }
  break;
   }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return app_localizations_en.loadLibrary().then((dynamic _) => app_localizations_en.AppLocalizationsEn());
    case 'ja': return app_localizations_ja.loadLibrary().then((dynamic _) => app_localizations_ja.AppLocalizationsJa());
    case 'zh': return app_localizations_zh.loadLibrary().then((dynamic _) => app_localizations_zh.AppLocalizationsZh());
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
