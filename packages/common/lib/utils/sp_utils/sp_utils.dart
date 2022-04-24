import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'sp_keys.dart';

class SPUtils {
  //静态私有成员，没有初始化
  static SPUtils? _instance;
  static SharedPreferences? _prefs;

  //私有构造函数
  SPUtils._() {
    //具体初始化代码
  }

  //静态，同步，私有访问点
  SPUtils.getInstance() {
    _instance ??= SPUtils._();
  }

  //实例化SharedPreferences
  Future<bool> initialization() async {
    _prefs = await SharedPreferences.getInstance();
    return true;
  }

  //获取SharedPreferences的实例对象
  SharedPreferences? getSharedPreferences() => _prefs;

  ///--------------------------------------------------------------------------

  //保存APP开发或者测试环境
  void saveAppEnv(final int prod) {
    _prefs?.setInt(SPKeys.appEnv, prod);
  }

  int getAppEnv(final int prod) => _prefs?.getInt(SPKeys.appEnv) ?? prod;

  ///--------------------------------------------------------------------------

  //保存主题选项位置
  void setThemeIndex(final String selectItem) {
    _prefs?.setString(SPKeys.themeIndex, selectItem);
  }

  String getThemeIndex() => _prefs?.getString(SPKeys.themeIndex) ?? '0';

  ///--------------------------------------------------------------------------

  //保存第一次进入状态
  void setFirstEnterState({required final bool isFirstEnter}) {
    _prefs?.setBool(SPKeys.isFirstEnter, isFirstEnter);
  }

  bool getFirstEnterState() => _prefs?.getBool(SPKeys.isFirstEnter) ?? false;

  ///--------------------------------------------------------------------------

  //保存登录状态
  //TODO 暂时用，后续使用数据库的用户信息来替代
  void setIsLoggedIn({required final bool isLoggedIn}) {
    _prefs?.setBool(SPKeys.isLoggedIn, isLoggedIn);
  }

  bool getIsLoggedIn() => _prefs?.getBool(SPKeys.isLoggedIn) ?? false;

  ///--------------------------------------------------------------------------

  //保存用户选择的国家代码
  void setAreaCode({
    required final int areaCode,
  }) {
    _prefs?.setInt(SPKeys.areaCode, areaCode);
  }

  int getAreaCode() => _prefs?.getInt(SPKeys.areaCode) ?? 86;

  ///--------------------------------------------------------------------------

  //保存audio列表
  void setAudioList({required final List<Map<String, String>> audioList}) {
    _prefs?.setString(SPKeys.audioList, jsonEncode(audioList));
  }

  List<dynamic> getAudioList() =>
      jsonDecode(_prefs?.getString(SPKeys.audioList) ?? '');

  ///--------------------------------------------------------------------------

  ///------------------ 用户金币相关 ------------------------------------------------

  //记录用户所有的金币个数
  void setCoins({required final int coins}) {
    _prefs?.setInt(SPKeys.coins, coins);
  }

  int getCoins() => _prefs?.getInt(SPKeys.coins) ?? 0;

  //记录用户休息的次数
  void setRestCount({required final int restCount}) {
    _prefs?.setInt(SPKeys.restCount, restCount);
  }

  int getRestCount() => _prefs?.getInt(SPKeys.restCount) ?? 0;

  //记录用户专注&休息的开始时间，一进入专注就记录，后面可能丢弃
  void setRestStartTimeTemp({required final String restStartTime}) {
    _prefs?.setString(SPKeys.restStartTime, restStartTime);
  }

  String getRestStartTimeTemp() =>
      _prefs?.getString(SPKeys.restStartTime) ?? '';

  //记录用户专注&休息的开始时间，只有在完成休息时才记录
  void setRestStartTime({required final String restStartTime}) {
    _prefs?.setString(SPKeys.restStartTime, restStartTime);
  }

  String getRestStartTime() => _prefs?.getString(SPKeys.restStartTime) ?? '';

  //记录用户专注&休息的结束时间
  void setRestEndTime({required final String restEndTime}) {
    _prefs?.setString(SPKeys.restEndTime, restEndTime);
  }

  String getRestEndTime() => _prefs?.getString(SPKeys.restEndTime) ?? '';

  ///--------------------------------------------------------------------------

  ///------------------ 倒计时相关 ---------------------------------------------

  //记录focus页面退到后台的时间戳
  void setFocusPausedTime({required final int focusPausedTime}) {
    _prefs?.setInt(SPKeys.focusPausedTime, focusPausedTime);
  }

  int getFocusPausedTime() => _prefs?.getInt(SPKeys.focusPausedTime) ?? 0;

  //记录result页面退到后台的时间戳
  void setResultPausedTime({required final int resultPausedTime}) {
    _prefs?.setInt(SPKeys.resultPausedTime, resultPausedTime);
  }

  int getResultPausedTime() => _prefs?.getInt(SPKeys.resultPausedTime) ?? 0;

  ///--------------------------------------------------------------------------
}
