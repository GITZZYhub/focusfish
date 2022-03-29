import 'package:common/theme/theme_provider.dart';
import 'package:common/utils/init_util.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:getx/getx.dart';
import 'package:localization/localization.dart';
import 'package:resources/resources.dart';

import '../../guide.dart';

class GuideView extends GetView<GuideController> {
  final pageController = PageController();

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: SafeArea(
          child: Obx(
            () => Swiper(
              key: const Key('guidePageView'),
              autoStart: false,
              indicator: CircleSwiperIndicator(
                radius: dim10w,
                spacing: dim16w,
                itemColor: ThemeProvider.indicatorItemColor.value,
                itemActiveColor: ThemeProvider.indicatorActiveItemColor.value,
              ),
              // childCount: controller.getPageSrcList(context).length,
              children: _initPageViewResources(
                controller.getPageSrcList(context),
                context,
              ),
            ),
          ),
        ),
      );

  List<Widget> _initPageViewResources(
    final List<String> imgNames,
    final BuildContext context,
  ) =>
      [
        Container(
          decoration: BoxDecoration(
            image: GetImage.getDecorationImage(imgNames[0], BoxFit.cover),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            image: GetImage.getDecorationImage(imgNames[1], BoxFit.cover),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            image: GetImage.getDecorationImage(imgNames[2], BoxFit.cover),
          ),
          child: Padding(
            padding: EdgeInsets.only(bottom: dim80h),
            child: ElevatedButton(
              key: const Key('guideButtonStart'),
              onPressed:
                  clickDebounce.clickDebounce(() => controller.enterSplash()),
              child: Text(
                AppLocalizations.of(context)!.enter_app,
              ),
            ),
          ),
        ),
      ];
}
