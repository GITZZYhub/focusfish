import 'package:common/utils/sp_utils/sp_utils.dart';
import 'package:my_logger/my_logger.dart';

enum AppEnv { dev, prod }

const _dev = 0;
const _prod = 1;

/// 切换app线上线下环境
void setAppEnv(final AppEnv env) {
  switch (env) {
    case AppEnv.prod:
      SPUtils.getInstance().saveAppEnv(_prod);
      break;
    default:
      SPUtils.getInstance().saveAppEnv(_dev);
  }
}

/// 获取当前app环境
AppEnv getCurrentAppEnv() {
  final env = SPUtils.getInstance().getAppEnv(_prod);
  switch (env) {
    case _prod:
      logCommonInfo(info: '当前处于生产环境', needStack: false);
      return AppEnv.prod;
    default:
      logCommonInfo(info: '当前处于测试环境', needStack: false);
      return AppEnv.dev;
  }
}
