import 'package:common/controller/base_controller.dart';
import 'package:getx/getx.dart';
import '../../my_data.dart';

class MyDataController extends BaseController {
  MyDataController({required final this.myDataRepository});

  final IMyDataRepository myDataRepository;

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
