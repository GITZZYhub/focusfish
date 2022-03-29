///验证中国大陆手机号码是否输入正确
bool isMobileExact(final String? text) {
  if (text != null && text.isNotEmpty) {
    final exp = RegExp(
      r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$',
    );
    return exp.hasMatch(text);
  }
  return false;
}

//验证中国香港手机号码输入输入正确
bool isHKMobileExact(final String? text) {
  if (text != null && text.isNotEmpty) {
    final exp = RegExp(r'^(5|6|8|9)\d{7}$');
    return exp.hasMatch(text);
  }
  return false;
}

///验证手机号码是否输入正确
bool isPhoneNum(final String? text) {
  if (text != null && text.isNotEmpty) {
    final exp = RegExp(
      r'(\+[0-9]+[\- \.]*)?(\([0-9]+\)[\- \.]*)?([0-9][0-9\- \.]+[0-9])',
    );
    return exp.hasMatch(text);
  }
  return false;
}

///验证邮箱是否输入正确
bool isEmail(final String? email) {
  if (email != null && email.isNotEmpty) {
    final exp = RegExp(r'^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$');
    return exp.hasMatch(email);
  }
  return false;
}
