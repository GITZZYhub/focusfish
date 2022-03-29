import 'package:getx/getx.dart';

import '../../guide/presentation/controllers/guide_controller.dart';
import '../../splash/data/splash_api_provider.dart';
import '../../splash/data/splash_repository.dart';
import '../../splash/presentation/controllers/splash_controller.dart';
import '../flash.dart';

class FlashBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(FlashController.new)
      ..lazyPut(GuideController.new)
      ..lazyPut(SplashProvider.new)
      ..lazyPut(() => SplashRepository(provider: Get.find<SplashProvider>()))
      ..lazyPut(
        () => SplashController(repository: Get.find<SplashRepository>()),
      );
  }
}
