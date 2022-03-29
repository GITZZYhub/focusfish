import 'package:getx/getx.dart';
import '../focus.dart';

class FocusBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<IFocusProvider>(() => FocusProvider())
      ..lazyPut<IFocusRepository>(() => FocusRepository(provider: Get.find()))
      ..lazyPut(() => FocusController(focusRepository: Get.find()));
  }
}
