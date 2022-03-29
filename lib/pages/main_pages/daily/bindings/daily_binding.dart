import 'package:getx/getx.dart';
import '../daily.dart';

class DailyBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<IDailyProvider>(() => DailyProvider())
      ..lazyPut<IDailyRepository>(() => DailyRepository(provider: Get.find()))
      ..lazyPut(() => DailyController(dailyRepository: Get.find()));
  }
}
