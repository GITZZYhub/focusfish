import 'package:getx/getx.dart';
import '../result.dart';

class ResultBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<IResultProvider>(() => ResultProvider())
      ..lazyPut<IResultRepository>(() => ResultRepository(provider: Get.find()))
      ..lazyPut(() => ResultController(resultRepository: Get.find()));
  }
}
