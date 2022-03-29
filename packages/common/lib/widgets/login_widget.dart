import 'package:common/entity/city.dart';
import 'package:common/event/change_area_code_event.dart';
import 'package:common/utils/init_util.dart';
import 'package:common/utils/sp_utils/sp_utils.dart';
import 'package:common/widgets/phone_area_code.dart';
import 'package:common/widgets/public_widget.dart';
import 'package:eventbus/eventbus.dart';
import 'package:flutter/material.dart';
import 'package:getx/getx.dart';
import 'package:resources/resources.dart';

///手机区号
Widget getAreaCodeWidget(
        {required final Key key, required final TextEditingController controller}) =>
    Container(
      alignment: Alignment.center,
      width: dim120w,
      child: TextFormField(
        key: key,
        controller: controller,
        readOnly: true,
        textAlign: TextAlign.center,
      ),
    );

///提取输入手机号码或者邮箱的TextFormField
Widget getInputTextFormField({
  required final Key? key,
  required final TextInputType keyboardType,
  required final TextEditingController? controller,
  required final bool isShowClearIconButton,
  required final String? labelText,
  final Widget? prefix,
  final FocusNode? focusNode,
  final String? errorText,
  final int? maxLength,
  final TextAlign? textAlign,
  final bool? enabled,
  final bool? readOnly,
}) =>
    TextFormField(
      key: key,
      enabled: enabled ?? true,
      readOnly: readOnly ?? false,
      keyboardType: keyboardType,
      focusNode: focusNode,
      controller: controller,
      maxLength: maxLength,
      minLines: 1,
      textAlign: textAlign ?? TextAlign.start,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefix,
        suffixIcon: isShowClearIconButton
            ? IconButton(
                onPressed: () => controller?.clear(),
                icon: const Icon(Icons.clear),
              )
            : null,
        errorText: errorText,
      ),
    );

///提取输入密码的TextFormField
Widget getPasswordTextField({
  required final Key key,
  required final TextEditingController controller,
  required final bool isShowPassword,
  required final String labelText,
  final String? errorText,
  required final bool isShowClearIconButton,
  required final Function fun,
}) =>
    TextFormField(
      key: key,
      keyboardType: TextInputType.text,
      controller: controller,
      obscureText: !isShowPassword,
      minLines: 1,
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText,
        suffixIcon: isShowClearIconButton
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => controller.clear(),
                    icon: const Icon(
                      Icons.clear,
                    ),
                  ),
                  IconButton(
                    onPressed: () => fun(),
                    icon: Icon(isShowPassword
                        ? Icons.remove_red_eye_rounded
                        : Icons.visibility_off_rounded),
                  ),
                ],
              )
            : IconButton(
                onPressed: () => fun(),
                icon: Icon(isShowPassword
                    ? Icons.remove_red_eye_rounded
                    : Icons.visibility_off_rounded),
              ),
      ),
    );

///手机区号
typedef AreaCodeCallback = void Function(int areaCode);
class PhoneNumAreaCodeWidget extends StatelessWidget {
  const PhoneNumAreaCodeWidget({
    final Key? key,
    required this.areaCodeText,
    required this.areaCodeCallback,
  }) : super(key: key);

  final String areaCodeText;
  final AreaCodeCallback areaCodeCallback;

  @override
  Widget build(final BuildContext context) => Row(
        children: [
          TextButton(
            onPressed: clickDebounce.clickDebounce(() {
              Get.to(() => const PhoneAreaCode())!.then((final value) {
                if (value != null) {
                  final city = value as City;
                  SPUtils.getInstance().setAreaCode(areaCode: city.code);
                  areaCodeCallback(city.code);
                }
              });
            }),
            child: Text(areaCodeText),
          ),
          const NextIcon(),
        ],
      );
}
