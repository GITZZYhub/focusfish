import 'package:flutter/material.dart';
import 'package:getx/getx.dart';

import '../../../guide/guide.dart';
import '../../../splash/presentation/views/splash_view.dart';
import '../../flash.dart';

class FlashView extends GetView<FlashController> {
  @override
  Widget build(final BuildContext context) =>
      controller.isFirstEnter ? GuideView() : SplashView();
}
