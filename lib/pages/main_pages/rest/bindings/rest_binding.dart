import 'package:getx/getx.dart';
import '../rest.dart';

class RestBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<IRestProvider>(() => RestProvider())
      ..lazyPut<IRestRepository>(() => RestRepository(provider: Get.find()))
      ..lazyPut(() => RestController(restRepository: Get.find()));
  }
}
