import 'package:common/constants/argument_keys.dart';
import 'package:common/controller/base_controller.dart';
import 'package:common/utils/sp_utils/sp_utils.dart';
import 'package:common/utils/time_util.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:getx/getx.dart';

import '../../../../../routes/app_pages.dart';
import '../../result.dart';

class ResultController extends BaseController {
  ResultController({required final this.resultRepository});

  final IResultRepository resultRepository;

  final _service = FlutterBackgroundService();

  late final List<dynamic> audioList;

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
    _service
      ..invoke('startResultPageTimer')
      ..on('resultPage').listen((final event) {
        if (event == null) {
          return;
        }
        countDown.value = staticTime - event['tick'] as int;
        time.value =
            TimeUtil.convertTime(countDown.value ~/ 60, countDown.value % 60);
        if (countDown.value <= 0) {
          gotoFocus();
        }
      });
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    _service.invoke('stopResultPageTimer');
    super.onClose();
  }
}
