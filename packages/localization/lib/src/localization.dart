import 'package:common/utils/sp_utils/sp_keys.dart';
import 'package:common/utils/sp_utils/sp_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/getx.dart';
import 'package:my_logger/my_logger.dart';

import 'all_languages.dart';
import 'app_localizations.dart';

class ServerLanguage {
  static const en = 'en-US';
  static const ja = 'ja-JP';
  static const zhCN = 'zh-CN';
  static const zhTW = 'zh-TW';
}

class D3Language {
  static const en = 'en';
  static const ja = 'ja';
  static const cn = 'cn';
  static const tw = 'tw';
}

class Language {
  static const int english = 0;
  static const int chinese = 1;
  static const int chineseTradition = 2;
  static const int japanese = 3;
}

String? get appLanguage =>
    SPUtils.getInstance().getSharedPreferences()?.getString(SPKeys.appLanguage);

///用在设置页面语言选项
class LocaleDisplayOption {
  final String title;
  final String? subtitle;

  LocaleDisplayOption(this.title, {final this.subtitle});
}

///默认语言
Locale defaultLocale = const Locale('en', '');

///日语locale
Locale localeJA = const Locale('ja', '');

Locale? locale(final BuildContext context) => _getCurrentLocale(context);

///获取当前应用语言
Locale? _getCurrentLocale(final BuildContext context) {
  final appLocalString = appLanguage;
  final supportedLocales = List<Locale>.from(AppLocalizations.supportedLocales);
  if (appLocalString == null || appLocalString.isEmpty) {
    logLocalizationInfo(
      info: '当前使用系统语言: ${Get.deviceLocale}',
      needStack: false,
    );
    if (supportedLocales.contains(Get.deviceLocale)) {
      // 如果app所支持的语言包含当前设备语言，则返回设备语言
      return Get.deviceLocale;
    } else {
      if (Get.deviceLocale.toString().contains(ja)) {
        //当所支持语言String含有这个语言String时，比如用户切换en_US，
        //我们应用没有适配该语言，但是en_US包含en，所以用en的locale，此处是ja
        return localeJA;
      } else {
        // 如果app所支持的语言不包含当前设备语言，则返回默认语言
        return defaultLocale;
      }
    }
  } else {
    logLocalizationInfo(info: '当前使用app设置的语言', needStack: false);

    final currentLocale = supportedLocales.firstWhereOrNull(
      (final element) => appLocalString == element.toString(),
    );
    logLocalizationInfo(
      info: 'app语言是：${currentLocale.toString()}',
      needStack: false,
    );
    return currentLocale;
  }
}

///是否是日语
bool isJa(final BuildContext context) =>
    listJA.contains(_getCurrentLocale(context).toString());

///是否是英语
bool isEn(final BuildContext context) =>
    listEN.contains(_getCurrentLocale(context).toString());

///是否是简体中文
bool isCN(final BuildContext context) =>
    listCN.contains(_getCurrentLocale(context).toString());

///是否是繁体中文
bool isTR(final BuildContext context) =>
    listTR.contains(_getCurrentLocale(context).toString());

///获取上传服务器所需的语言格式
String getCurrentServerLanguage(final BuildContext context) {
  var lang = ServerLanguage.en;
  if (isJa(context)) {
    lang = ServerLanguage.ja;
  } else if (isCN(context)) {
    lang = ServerLanguage.zhCN;
  } else if (isTR(context)) {
    lang = ServerLanguage.zhTW;
  } else {
    lang = ServerLanguage.en;
  }
  // logLocalizationInfo(info: '传给服务器的语言是：$lang', needStack: false);
  return lang;
}

String getCurrent3DLanguage(final BuildContext context) {
  String lang;
  if (isJa(context)) {
    lang = D3Language.ja;
  } else if (isCN(context)) {
    lang = D3Language.cn;
  } else if (isTR(context)) {
    lang = D3Language.tw;
  } else {
    lang = D3Language.en;
  }
  return lang;
}

int getCurrentLanguage(final BuildContext context) {
  var lang = Language.english;
  if (isJa(context)) {
    lang = Language.japanese;
  } else if (isCN(context)) {
    lang = Language.chinese;
  } else if (isTR(context)) {
    lang = Language.chineseTradition;
  } else {
    lang = Language.english;
  }
  return lang;
}

/// 获取app的语言设置选项
List<String> get languageList => listAppLanguages;

/// 获取app当前语言设置index
int currentLanguageIndex(final BuildContext context) {
  if (isCN(context)) {
    logLocalizationInfo(info: 'app当前语言设置index: $cnPosition', needStack: false);
    return cnPosition;
  } else if (isEn(context)) {
    logLocalizationInfo(info: 'app当前语言设置index: $enPosition', needStack: false);
    return enPosition;
  } else if (isTR(context)) {
    logLocalizationInfo(info: 'app当前语言设置index: $trPosition', needStack: false);
    return trPosition;
  } else if (isJa(context)) {
    logLocalizationInfo(info: 'app当前语言设置index: $jaPosition', needStack: false);
    return jaPosition;
  } else {
    logLocalizationInfo(info: 'app当前语言设置index: $enPosition', needStack: false);
    return enPosition;
  }
}

/// 获取app当前语言设置index
String currentLanguage(final BuildContext context) {
  if (isCN(context)) {
    logLocalizationInfo(
      info: 'app当前语言设置: ${languageList[cnPosition]}',
      needStack: false,
    );
    return languageList[cnPosition];
  } else if (isEn(context)) {
    logLocalizationInfo(
      info: 'app当前语言设置: ${languageList[enPosition]}',
      needStack: false,
    );
    return languageList[enPosition];
  } else if (isTR(context)) {
    logLocalizationInfo(
      info: 'app当前语言设置: ${languageList[trPosition]}',
      needStack: false,
    );
    return languageList[trPosition];
  } else if (isJa(context)) {
    logLocalizationInfo(
      info: 'app当前语言设置: ${languageList[jaPosition]}',
      needStack: false,
    );
    return languageList[jaPosition];
  } else {
    logLocalizationInfo(
      info: 'app当前语言设置: ${languageList[enPosition]}',
      needStack: false,
    );
    return languageList[enPosition];
  }
}

///设置语言
void setAppLanguage(final int languageIndex) {
  switch (languageIndex) {
    case cnPosition:
      SPUtils.getInstance()
          .getSharedPreferences()
          ?.setString(SPKeys.appLanguage, zhCN);
      logLocalizationInfo(info: '设置语言: $zh', needStack: false);
      Get.updateLocale(const Locale(zh));
      break;
    case enPosition:
      SPUtils.getInstance()
          .getSharedPreferences()
          ?.setString(SPKeys.appLanguage, en);
      logLocalizationInfo(info: '设置语言: $en', needStack: false);
      Get.updateLocale(const Locale(en));
      break;
    case trPosition:
      SPUtils.getInstance()
          .getSharedPreferences()
          ?.setString(SPKeys.appLanguage, zhHK);
      logLocalizationInfo(info: '设置语言: $zhHK', needStack: false);
      Get.updateLocale(Locale(zhHK.split('_')[0], zhHK.split('_')[1]));
      break;
    case jaPosition:
      SPUtils.getInstance()
          .getSharedPreferences()
          ?.setString(SPKeys.appLanguage, ja);
      logLocalizationInfo(info: '设置语言: $ja', needStack: false);
      Get.updateLocale(const Locale(ja));
      break;
    default:
      SPUtils.getInstance()
          .getSharedPreferences()
          ?.setString(SPKeys.appLanguage, en);
      logLocalizationInfo(info: '设置语言: $en', needStack: false);
      Get.updateLocale(const Locale(en));
      break;
  }
}
