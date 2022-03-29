import 'package:common/controller/base_controller.dart';
import 'package:getx/getx.dart';

import '../../../../../routes/app_pages.dart';
import '../../home.dart';

class HomeController extends BaseController {
  HomeController({required final this.homeRepository});

  final IHomeRepository homeRepository;

  final tabs = ['工作鱼', '健身鱼', '学习鱼', '冥想鱼', '任意鱼'];

  void gotoFocusPage() {
    Get.toNamed(Routes.focus);
  }

  void gotoDailyPage() {
    Get.toNamed(Routes.daily);
  }

  void gotoMyDataPage() {
    Get.toNamed(Routes.my_data);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
