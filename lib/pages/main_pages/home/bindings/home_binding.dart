import 'package:getx/getx.dart';
import '../home.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<IHomeProvider>(HomeProvider.new)
      ..lazyPut<IHomeRepository>(() => HomeRepository(provider: Get.find()))
      ..lazyPut(() => HomeController(homeRepository: Get.find()));
  }
}
