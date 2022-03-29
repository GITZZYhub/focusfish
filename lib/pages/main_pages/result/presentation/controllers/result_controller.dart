import 'package:common/constants/argument_keys.dart';
import 'package:common/controller/base_controller.dart';
import 'package:getx/getx.dart';

import '../../../../../routes/app_pages.dart';
import '../../result.dart';

class ResultController extends BaseController {
  ResultController({required final this.resultRepository});

  final IResultRepository resultRepository;

  Map<String, dynamic>? _arguments;

  String focusTime = '';

  void goBack() {
    Get.back();
  }

  void gotoNextPage() {
    Get.offNamed(Routes.rest);
  }

  @override
  void onInit() {
    super.onInit();
    _arguments = Get.arguments;
    if (_arguments != null) {
      focusTime = _arguments?[ArgumentKeys.focusTime];
    }
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
