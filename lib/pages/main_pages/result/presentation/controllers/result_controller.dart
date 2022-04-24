import 'dart:async';

import 'package:common/constants/argument_keys.dart';
import 'package:common/controller/base_controller.dart';
import 'package:common/utils/sp_utils/sp_utils.dart';
import 'package:common/utils/time_util.dart';
import 'package:getx/getx.dart';

import '../../../../../routes/app_pages.dart';
import '../../result.dart';

class ResultController extends BaseController {
  ResultController({required final this.resultRepository});

  final IResultRepository resultRepository;

  // 倒计时
  Timer? _countDownTimer;

  late final List<dynamic> audioList;

  //倒计时总时间
  final _staticTime = 5 * 60;

  //倒计时剩余时间
  final countDown = 0.obs;

  //ui显示的时间
  final time = ''.obs;

  // 处于后台的时间长度
  int backgroundLastTime = 0;

  bool? isInBackGround;

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
    _initTimer(_staticTime);
  }

  void _initTimer(final int curTime) {
    countDown.value = curTime;
    time.value =
        TimeUtil.convertTime(countDown.value ~/ 60, countDown.value % 60);
    _countDownTimer = Timer.periodic(const Duration(seconds: 1), (final timer) {
      countDown.value = curTime - timer.tick;
      time.value =
          TimeUtil.convertTime(countDown.value ~/ 60, countDown.value % 60);
      if (countDown.value <= 0) {
        timer.cancel();
        gotoFocus();
      }
    });
  }

  @override
  void onPaused() {
    super.onPaused();
    isInBackGround = true;
    SPUtils.getInstance().setResultPausedTime(
      resultPausedTime: DateTime.now().millisecondsSinceEpoch,
    );
    _countDownTimer?.cancel();
  }

  @override
  void onResumed() {
    super.onResumed();
    //如果是从paused而不是inactive回来
    if (isInBackGround ?? false) {
      backgroundLastTime = ((DateTime.now().millisecondsSinceEpoch -
                  SPUtils.getInstance().getResultPausedTime()) /
              1000)
          .round();
      _initTimer(
        countDown.value - backgroundLastTime < 0
            ? 0
            : countDown.value - backgroundLastTime,
      );
    }
    isInBackGround = false;
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    _countDownTimer?.cancel();
    super.onClose();
  }
}
