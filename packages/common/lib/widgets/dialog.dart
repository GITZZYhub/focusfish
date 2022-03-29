import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getx/getx.dart';
import 'package:localization/localization.dart';
import 'package:resources/resources.dart';

enum DialogType {
  tips,
  warning,
  error,
}

///创建提示Dialog
Future<bool?> showCustomDialog(
  final BuildContext context, {
  required final DialogType type,
  required final String title,
  required final String content,
  required final bool doubleButton,
  required final bool cancellable,
  final bool? closeOverlays, //是否同时关闭当前页面
}) async =>
    showDialog<bool>(
      context: context,
      barrierDismissible: cancellable,
      builder: (final context) => WillPopScope(
        //禁止返回键取消dialog
        onWillPop: () async => cancellable,
        child: AlertDialog(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (type == DialogType.tips)
                Icon(
                  Icons.notification_important,
                  color: ColorRes.tipsColor,
                )
              else if (type == DialogType.warning)
                Icon(
                  Icons.warning,
                  color: ColorRes.warningColor,
                )
              else
                const Icon(
                  Icons.error,
                  color: ColorRes.errorColor,
                ),
              SizedBox(
                width: dim10w,
              ),
              Text(title),
            ],
          ),
          content: Text(
            content,
          ),
          actions: <Widget>[
            if (doubleButton)
              TextButton(
                key: const Key('cancel'),
                onPressed: () {
                  Get.back(
                    result: false,
                  );
                },
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                ),
              )
            else
              const Text(''),
            TextButton(
              key: const Key('confirm'),
              onPressed: () {
                Get.back(
                  result: true,
                  closeOverlays: closeOverlays ?? false,
                );
              },
              child: Text(
                AppLocalizations.of(context)!.confirm,
              ),
            ),
          ],
          actionsPadding: EdgeInsets.symmetric(horizontal: dim20w),
        ),
      ),
    );

///显示dialog
bool showRequestLoading(final BuildContext context) {
  loadingDialog(context);
  return true;
}

///取消dialog
bool hideLoading({required final bool isShowingDialog}) {
  if (isShowingDialog) {
    Get.back();
  }
  return false;
}

///加载dialog
Future<void> loadingDialog(final BuildContext context) => showDialog(
  context: context,
  barrierColor: Colors.black26,
  barrierDismissible: false,
  builder: (final context) => WillPopScope(
    onWillPop: () async => true,
    child: Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: Center(
        //保证控件居中效果
        child: CupertinoActivityIndicator(
          radius: dim38w,
        ),
      ),
    ),
  ),
);
