import 'package:common/controller/base_controller.dart';
import 'package:common/utils/time_util.dart';
import 'package:focus_fish/routes/app_pages.dart';
import 'package:getx/getx.dart';
import 'package:pausable_timer/pausable_timer.dart';

import '../../rest.dart';

class RestController extends BaseController {
  RestController({required final this.restRepository});

  final IRestRepository restRepository;

  //倒计时器
  late final PausableTimer _timer;
  //倒计时总时间
  final staticTime = 1 * 60;
  //倒计时剩余时间
  final countDown = 0.obs;
  //ui显示的时间
  final time = ''.obs;

  void goBack() {
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    countDown.value = staticTime;
    time.value =
        TimeUtil.convertTime(countDown.value ~/ 60, countDown.value % 60);
    _timer = PausableTimer(const Duration(seconds: 1), () {
      countDown.value--;
      time.value =
          TimeUtil.convertTime(countDown.value ~/ 60, countDown.value % 60);
      if (countDown.value > 0) {
        // we know the callback won't be called before the constructor ends, so
        // it is safe to use !
        _timer
          ..reset()
          ..start();
      } else if (countDown.value == 0) {
        Get.offNamed(Routes.focus);
      }
    })
      ..start();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
