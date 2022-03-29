import 'package:common/utils/init_util.dart';
import 'package:common/widgets/login_widget.dart';
import 'package:common/widgets/public_widget.dart';
import 'package:flutter/material.dart';
import 'package:getx/getx.dart';
import 'package:localization/localization.dart';
import 'package:resources/resources.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(final BuildContext context) => Scaffold(
        ///适配不规则屏幕
        body: SafeArea(
          /// 触摸收起键盘
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: EdgeInsets.only(
                  left: dim56w,
                  top: dim60h,
                  right: dim56w,
                  bottom: dim20h,
                ),
                child: Column(
                  children: [
                    _getLoginThemeWidget(context),
                    SizedBox(
                      height: dim50h,
                    ),
                    _getPhoneTextField(context),
                    SizedBox(
                      height: dim20h,
                    ),
                    _getPasswordTextField(context),
                    SizedBox(
                      height: dim6h,
                    ),
                    _getRegisterTextWidget(context),
                    SizedBox(
                      height: dim100h,
                    ),
                    _getLoginButtonWidget(context),
                    SizedBox(
                      height: dim50h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  ///登录页面主题
  Widget _getLoginThemeWidget(final BuildContext context) => Row(
        children: [
          HeadLine6Text(
            text: AppLocalizations.of(context)!.login,
          ),
        ],
      );

  ///手机号码输入框
  Widget _getPhoneTextField(final BuildContext context) => Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Obx(
              () => PhoneNumAreaCodeWidget(
                areaCodeText: '+${controller.areaCode}',
                areaCodeCallback: (final areaCode) {
                  controller.areaCode.value = areaCode;
                },
              ),
            ),
          ),
          Obx(
            () => getInputTextFormField(
              key: const Key('loginInputPhone'),
              keyboardType: TextInputType.phone,
              controller: controller.phoneController,
              isShowClearIconButton:
                  controller.isShowClearPhoneIconButton.value,
              labelText: AppLocalizations.of(context)!.phone_number,
              errorText: controller.phoneNumVerifyFailureText.value.isEmpty
                  ? null
                  : controller.phoneNumVerifyFailureText.value,
            ),
          ),
        ],
      );

  ///密码输入框
  Widget _getPasswordTextField(final BuildContext context) => Obx(
        () => getPasswordTextField(
          key: const Key('loginInputPassword'),
          controller: controller.passwordController,
          isShowPassword: controller.isShowPassword.value,
          labelText: AppLocalizations.of(context)!.input_password,
          isShowClearIconButton: controller.isShowClearPasswordIconButton.value,
          errorText: controller.passwordVerifyFailureText.value.isEmpty
              ? null
              : controller.passwordVerifyFailureText.value,
          fun: () {
            controller.changePasswordDisplayState();
          },
        ),
      );

  ///账号注册及忘记密码
  Widget _getRegisterTextWidget(final BuildContext context) => Row(
        children: [
          CaptionText(
            text: AppLocalizations.of(context)!.register_an_account,
          ),
          TextButton(
            key: const Key('register'),
            onPressed:
                clickDebounce.clickDebounce(() => controller.enterRegisterUI()),
            child: Text(
              AppLocalizations.of(context)!.sign_up_immediately,
              style: TextStyle(fontSize: caption),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                key: const Key('forgetPassword'),
                onPressed: clickDebounce
                    .clickDebounce(() => controller.enterForgetPasswordUI()),
                child: Text(
                  AppLocalizations.of(context)!.forgot_password,
                  style: TextStyle(fontSize: caption),
                ),
              ),
            ),
          ),
        ],
      );

  ///登录按钮
  Widget _getLoginButtonWidget(final BuildContext context) => Row(
        children: [
          Expanded(
            child: Obx(
              () => ElevatedButton(
                key: const Key('loginButton'),
                onPressed: controller.isLoginButtonEnable.value
                    ? clickDebounce.clickDebounce(
                        () => controller.login(context),
                      )
                    : null,
                child: Text(
                  AppLocalizations.of(context)!.login,
                ),
              ),
            ),
          ),
        ],
      );
}
