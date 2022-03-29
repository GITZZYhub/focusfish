import 'package:getx/getx.dart';

import '../data/splash_api_provider.dart';
import '../data/splash_repository.dart';
import '../presentation/controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<SplashProvider>(SplashProvider.new)
      ..lazyPut<SplashRepository>(
        () => SplashRepository(provider: Get.find<SplashProvider>()),
      )
      ..lazyPut(
        () => SplashController(repository: Get.find<SplashRepository>()),
      );
  }
}
