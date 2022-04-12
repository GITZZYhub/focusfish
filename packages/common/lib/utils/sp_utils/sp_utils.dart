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

  ///实例化SharedPreferences
  Future<bool> initialization() async {
    _prefs = await SharedPreferences.getInstance();
    return true;
  }

  ///获取SharedPreferences的实例对象
  SharedPreferences? getSharedPreferences() => _prefs;

  ///--------------------------------------------------------------------------

  ///保存APP开发或者测试环境
  void saveAppEnv(final int prod) {
    _prefs?.setInt(SPKeys.appEnv, prod);
  }

  int getAppEnv(final int prod) => _prefs?.getInt(SPKeys.appEnv) ?? prod;

  ///--------------------------------------------------------------------------

  ///保存主题选项位置
  void setThemeIndex(final String selectItem) {
    _prefs?.setString(SPKeys.themeIndex, selectItem);
  }

  String getThemeIndex() => _prefs?.getString(SPKeys.themeIndex) ?? '0';

  ///--------------------------------------------------------------------------

  ///保存第一次进入状态
  void setFirstEnterState({required final bool isFirstEnter}) {
    _prefs?.setBool(SPKeys.isFirstEnter, isFirstEnter);
  }

  bool getFirstEnterState() => _prefs?.getBool(SPKeys.isFirstEnter) ?? false;

  ///--------------------------------------------------------------------------

  ///保存登录状态
  //TODO 暂时用，后续使用数据库的用户信息来替代
  void setIsLoggedIn({required final bool isLoggedIn}) {
    _prefs?.setBool(SPKeys.isLoggedIn, isLoggedIn);
  }

  bool getIsLoggedIn() => _prefs?.getBool(SPKeys.isLoggedIn) ?? false;

  ///--------------------------------------------------------------------------

  ///保存用户选择的国家代码
  void setAreaCode({
    required final int areaCode,
  }) {
    _prefs?.setInt(SPKeys.areaCode, areaCode);
  }

  int getAreaCode() => _prefs?.getInt(SPKeys.areaCode) ?? 86;

  ///--------------------------------------------------------------------------
}
