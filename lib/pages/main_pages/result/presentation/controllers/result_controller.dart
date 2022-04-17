import 'package:common/constants/argument_keys.dart';
import 'package:common/controller/base_controller.dart';
import 'package:common/utils/sp_utils/sp_utils.dart';
import 'package:common/utils/time_util.dart';
import 'package:getx/getx.dart';
import 'package:pausable_timer/pausable_timer.dart';

import '../../../../../routes/app_pages.dart';
import '../../result.dart';

class ResultController extends BaseController {
  ResultController({required final this.resultRepository});

  final IResultRepository resultRepository;

  late final List<dynamic> audioList;

  //倒计时器
  late final PausableTimer _timer;

  //倒计时总时间
  final staticTime = 5 * 60;

  //倒计时剩余时间
  final countDown = 0.obs;

  //ui显示的时间
  final time = ''.obs;

  void goBack() {
    Get.back();
  }

  void gotoRest(final String audioTitle) {
    final arguments = {
      ArgumentKeys.audioItem: audioList
          .firstWhere((final element) => element['title'] == audioTitle),
    };
    Get.offNamed(Routes.rest, arguments: arguments);
  }

  void gotoFocus() {
    Get.offNamed(Routes.focus);
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    audioList = SPUtils.getInstance().getAudioList();
    _initTimer();
  }

  void _initTimer() {
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
        gotoFocus();
      }
    })
      ..start();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
