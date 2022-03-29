import 'package:common/controller/base_controller.dart';
import 'package:common/widgets/pie_chart.dart';
import 'package:getx/getx.dart';

import '../../daily.dart';

class DailyController extends BaseController {
  DailyController({required final this.dailyRepository});

  final IDailyRepository dailyRepository;

  void goBack() {
    Get.back();
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
