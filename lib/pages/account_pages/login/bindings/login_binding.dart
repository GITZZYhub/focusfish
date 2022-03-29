import 'package:getx/getx.dart';

import '../data/login_api_provider.dart';
import '../data/login_repository.dart';
import '../presentation/controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<LoginProvider>(LoginProvider.new)
      ..lazyPut<LoginRepository>(() => LoginRepository(provider: Get.find()))
      ..put(LoginController(repository: Get.find()));
  }
}
