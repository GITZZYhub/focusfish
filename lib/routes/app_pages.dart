import 'package:getx/getx.dart';

import '../pages/account_pages/login/bindings/login_binding.dart';
import '../pages/account_pages/login/presentation/views/login_view.dart';
import '../pages/main_pages/daily/daily.dart';
import '../pages/main_pages/focus/focus.dart';
import '../pages/main_pages/home/bindings/home_binding.dart';
import '../pages/main_pages/home/presentation/views/views.dart';
import '../pages/main_pages/my_data/my_data.dart';
import '../pages/main_pages/rest/bindings/bindings.dart';
import '../pages/main_pages/rest/presentation/presentation.dart';
import '../pages/main_pages/result/bindings/bindings.dart';
import '../pages/main_pages/result/presentation/presentation.dart';
import '../pages/start_pages/flash/bindings/flash_binding.dart';
import '../pages/start_pages/flash/presentation/views/flash_view.dart';
import '../pages/start_pages/splash/bindings/splash_binding.dart';
import '../pages/start_pages/splash/presentation/views/splash_view.dart';

part 'app_routes.dart';

final appPageRoutes = [
  GetPage(
    name: Paths.flash,
    page: FlashView.new,
    binding: FlashBinding(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: Paths.splash,
    page: SplashView.new,
    binding: SplashBinding(),
    transition: Transition.fadeIn,
  ),
  GetPage(
    name: Paths.login,
    page: LoginView.new,
    binding: LoginBinding(),
    transition: Transition.downToUp,
    children: [],
  ),
  GetPage(
    name: Paths.home,
    page: HomeView.new,
    binding: HomeBinding(),
    transition: Transition.rightToLeft,
    children: [
      GetPage(
        name: Paths.focus,
        page: FocusView.new,
        binding: FocusBinding(),
        transition: Transition.downToUp,
      ),
      GetPage(
        name: Paths.result,
        page: ResultView.new,
        binding: ResultBinding(),
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: Paths.rest,
        page: RestView.new,
        binding: RestBinding(),
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: Paths.daily,
        page: DailyView.new,
        binding: DailyBinding(),
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: Paths.my_data,
        page: MyDataView.new,
        binding: MyDataBinding(),
        transition: Transition.rightToLeft,
      ),
    ],
  ),
];
