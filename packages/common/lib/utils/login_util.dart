import 'dart:io';

import 'package:common/utils/regex_util.dart';

///验证手机号码
bool verifyPhoneNum(final int areaCode, final String phoneNum) {
  var isPhoneNumVerifySuccess = false;
  if (areaCode == 86) {
    //中国大陆手机区号
    isPhoneNumVerifySuccess = isMobileExact(phoneNum);
  } else if (areaCode == 852) {
    //中国香港手机区号
    isPhoneNumVerifySuccess = isHKMobileExact(phoneNum);
  } else {
    //其他地区手机区号
    return true;
  }
  return isPhoneNumVerifySuccess;
}

///验证邮箱
bool verifyEmail(final String email) => isEmail(email);

///验证密码
bool verifyPassword(final String password) => password.length >= 6;

///设备平台
String devicePlatform() {
  if (Platform.isIOS) {
    return '1';
  } else {
    return '0';
  }
}


