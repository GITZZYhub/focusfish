class ServerCode {
  static const String success = '200';
  static const String failure = '1';
  static const String missingRequiredArgs = '40';
  static const String invalideArgs = '41';
  static const String serviceUnavailable = '50';

  ///获取记录为null或者用户不存在
  static const String notFound = '51';

  ///用户已存在
  static const String existAlready = '52';

  static const String incorrectAuth = '53';
  static const String nonUniqueObject = '54';

  ///账户异常或账户被锁(检查用户是否存在时)
  static const String userLocked = '55';

  ///账户解绑时，因只有一个绑定账号，无法解绑时(账户管理)
  static const String invalidRequest = '59';
  static const String expired = '60';

  ///发次验证码次数过多(登录，注册，忘记密码，账户管理)
  static const String emailCodeRequestTooFast = '63';
  static const String alreadyExistRecord = '64';

  // new
  static const String newMissingRequiredArgs = 'BA10002';

  static const String newInvalidArgs = 'BA10003';

  ///账户未注册
  static const String newNotFound = 'BA10004';

  ///密码错误
  static const String newIncorrectAuth = 'AC10002';

  ///该账号已经绑定其他设备(企业登录)
  static const String newNonUniqueObject = 'AC10005';

  ///您的账户异常，联系我们
  static const String nwUserLocked = 'AC10003';
}
