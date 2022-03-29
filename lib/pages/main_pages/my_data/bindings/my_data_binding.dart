import 'package:getx/getx.dart';
import '../my_data.dart';

class MyDataBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<IMyDataProvider>(() => MyDataProvider())
      ..lazyPut<IMyDataRepository>(() => MyDataRepository(provider: Get.find()))
      ..lazyPut(() => MyDataController(myDataRepository: Get.find()));
  }
}
