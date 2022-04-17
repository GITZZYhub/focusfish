import 'package:common/theme/app_theme_data.dart';
import 'package:common/theme/theme_provider.dart';
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
        ),
      );
}
