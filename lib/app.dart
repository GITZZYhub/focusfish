import 'package:common/event/redraw_water_animation.dart';
import 'package:common/event/show_add_coins_dialog_event.dart';
import 'package:common/theme/app_theme_data.dart';
import 'package:common/theme/theme_provider.dart';
import 'package:common/utils/sp_utils/sp_utils.dart';
import 'package:eventbus/eventbus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:getx/getx.dart';
import 'package:localization/localization.dart';
import 'package:resources/resources.dart';

import 'routes/routes.dart';

class App extends StatelessWidget {
  @override
  Widget build(final BuildContext context) => ScreenUtilInit(
        // 屏幕适配
        designSize: const Size(1080, 1920),
        builder: (final context) => GetMaterialApp(
          debugShowCheckedModeBanner: kDebugMode,
          enableLog: kDebugMode,
          logWriterCallback: GetxLogger.write,
          themeMode: getAppThemeMode(),
          theme: lightThemeData,
          darkTheme: darkThemeData,
          initialRoute: Routes.initial,
          getPages: appPageRoutes,
          localizationsDelegates: const [
            ...AppLocalizations.localizationsDelegates,
            LocaleNamesLocalizationsDelegate()
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          localeListResolutionCallback:
              (final locales, final supportedLocales) => locale(context),
          routingCallback: (final routing) {
            if (routing?.current == Routes.home) {
              //home界面的水波纹动画需要在每次进入页面都重新启动，否则会失效
              eventBus.fire(RedrawWaterAnimationEvent());
              //金币奖励对话框
              if (routing?.route is! DialogRoute &&
                  SPUtils.getInstance().getRestCount() != 0) {
                eventBus.fire(ShowAddCoinsDialogEvent());
              }
            }
          },
        ),
      );
}
