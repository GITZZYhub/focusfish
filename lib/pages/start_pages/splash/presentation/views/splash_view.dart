import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getx/getx.dart';
import 'package:localization/localization.dart';
import 'package:resources/resources.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(final BuildContext context) => Scaffold(
        //添加应用主题背景
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image:
                  GetImage.getDecorationImage(R.png.launchImage, BoxFit.none),
            ),
            child: _showSplashWidget(context),
          ),
        ),
      );

  Widget _showSplashWidget(final BuildContext context) {
    controller.initialized;
    return _getSplashLoadingWidget(context);
  }

  ///获取加载页面的Widget
  Widget _getSplashLoadingWidget(final BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CupertinoActivityIndicator(),
              Padding(
                padding: EdgeInsets.only(left: dim18w),
                child: Text(
                  AppLocalizations.of(context)!.loading_text,
                  style: Theme.of(Get.context!).textTheme.caption,
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: dim16h, bottom: dim18h),
            child: Text(
              AppLocalizations.of(context)!.company_info,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.overline,
            ),
          )
        ],
      );
}
