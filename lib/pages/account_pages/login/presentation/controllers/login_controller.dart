import 'package:common/constants/sever_keys.dart';
import 'package:common/utils/login_util.dart';
import 'package:common/utils/sp_utils/sp_utils.dart';
import 'package:common/utils/toast_util.dart';
import 'package:common/widgets/dialog.dart';
import 'package:dio_http/dio_http.dart';
import 'package:eventbus/eventbus.dart';
import 'package:flutter/material.dart';
import 'package:getx/getx.dart';
import 'package:localization/localization.dart';
import 'package:my_logger/my_logger.dart';

import '../../../../../routes/app_pages.dart';
import '../../../base_account/presentation/controllers/base_account_controller.dart';
import '../../data/login_repository.dart';
import '../../event/event.dart';

class LoginController extends BaseAccountController {
  LoginController({required final this.repository})
      : super(baseRepository: repository);

  final LoginRepository repository;

  bool _isShowingDialog = false;

  ///是否显示清除图标按钮
  final isShowClearPhoneIconButton = false.obs;
  final isShowClearPasswordIconButton = false.obs;

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  ///密码是否可见
  final isShowPassword = false.obs;
  final areaCode = SPUtils.getInstance().getAreaCode().obs;

  ///监听手机号码是否输入正确
  final phoneNumVerifyFailureText = ''.obs;
  final passwordVerifyFailureText = ''.obs;

  ///监听登陆按钮是否可以点击
  final isLoginButtonEnable = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    ///监听手机号码输入
    phoneController.addListener(() {
      if (phoneController.text.isNotEmpty) {
        isShowClearPhoneIconButton.value = true;
      } else {
        isShowClearPhoneIconButton.value = false;
        phoneNumVerifyFailureText.value = '';
      }
      _refreshLoginButton();
    });

    ///监听密码输入
    passwordController.addListener(() {
      if (passwordController.text.isNotEmpty) {
        isShowClearPasswordIconButton.value = true;
      } else {
        isShowClearPasswordIconButton.value = false;
        passwordVerifyFailureText.value = '';
      }
      _refreshLoginButton();
    });
  }

  ///刷新登录按钮
  void _refreshLoginButton() {
    isLoginButtonEnable.value = phoneController.text.isNotEmpty &&
        verifyPassword(passwordController.text);
  }

  @override
  void onResumed() {
    super.onResumed();
    _isShowingDialog = hideLoading(isShowingDialog: _isShowingDialog);
  }

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
    repository.cancelLoginRequest();
  }

  ///修改登录密码是否可见
  void changePasswordDisplayState() {
    isShowPassword.value = !isShowPassword.value;
  }

  ///跳转到账号注册页面
  void enterRegisterUI() {}

  ///跳转到忘记密码页面
  void enterForgetPasswordUI() {}

  ///验证账号信息是否正确
  bool _verifyAccountInfoIsSuccess() {
    if (!verifyPhoneNum(areaCode.value, phoneController.text)) {
      phoneNumVerifyFailureText.value =
          AppLocalizations.of(Get.context!)!.wrong_phone_num;
      return false;
    } else {
      return true;
    }
  }

  void _refreshAccountErrorTips() {
    phoneNumVerifyFailureText.value = '';
    passwordVerifyFailureText.value = '';
  }

  ///登录
  void login(final BuildContext context) {
    if (_verifyAccountInfoIsSuccess()) {
      _refreshAccountErrorTips();
      _isShowingDialog = showRequestLoading(context);
      final queryParameters = <String, dynamic>{};
      queryParameters[ServerKeys.identifier] =
          '$areaCode:${phoneController.text}';
      queryParameters[ServerKeys.credential] = passwordController.text;
      if (!isClosed) {
        sendLoginRequest(
          context,
          queryParameters,
          '',
          '',
        );
      }
    } else {}
  }

  ///发送登录请求
  Future<void> sendLoginRequest(
    final BuildContext context,
    final Map<String, dynamic> queryParameters,
    final String nickname,
    final String userID,
  ) async {
    //调用登录接口
    await repository.login(queryParameters).then(
      (final loginResponse) {
        _isShowingDialog = hideLoading(isShowingDialog: _isShowingDialog);
        if (!isClosed) {
          debugPrint('个人登陆成功');
          Get.offNamed<dynamic>(Routes.home);
          //获取登录数据成功，将用户登录数据保存到本地数据库
          // saveLoginUserInfo(
          //   context: context,
          //   loginData: loginResponse,
          // ).then(
          //   (final value) {
          //     debugPrint('保存个人登陆数据成功');
          //     Get.until((final route) => Get.currentRoute == Routes.main);
          //   },
          //   onError: (final error) {
          //     logDatabaseError(error: '$error', needStack: false);
          //   },
          // );
        }
      },
      onError: (final error) async {
        _isShowingDialog = hideLoading(isShowingDialog: _isShowingDialog);
        logHttpError(error: '登录错误信息：error：($error)', needStack: false);
        if (!isClosed) {
          if (error is BadRequestException) {
            final errorCode = error.code;
            switch (errorCode) {
              case ServerCode.failure:
              case ServerCode.nwUserLocked:
                break;
              case ServerCode.newNotFound:
                phoneNumVerifyFailureText.value =
                    AppLocalizations.of(Get.context!)!.user_not_exist;
                break;
              case ServerCode.newIncorrectAuth:
                passwordVerifyFailureText.value =
                    AppLocalizations.of(Get.context!)!.wrong_psw;
                break;
              default:
                showNetworkToast(error);
                break;
            }
          } else {
            showNetworkToast(error);
          }
        }
      },
    );
  }
}
