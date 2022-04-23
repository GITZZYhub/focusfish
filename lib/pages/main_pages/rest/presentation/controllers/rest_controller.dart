import 'dart:async';

import 'package:common/audio_services/audio_manager.dart';
import 'package:common/constants/argument_keys.dart';
import 'package:common/controller/base_controller.dart';
import 'package:common/event/audio_play_complete.dart';
import 'package:common/utils/sp_utils/sp_utils.dart';
import 'package:eventbus/eventbus.dart';
import 'package:getx/getx.dart';
import 'package:intl/intl.dart';

import '../../../../../routes/app_pages.dart';
import '../../rest.dart';

class RestController extends BaseController {
  RestController({required final this.restRepository});

  final IRestRepository restRepository;

  final AudioManager audioManager = Get.find<AudioManager>();
  late final List<dynamic> audioList;

  int? currentDuration;
  final timeRemain = 0.obs;

  late final Map<String, dynamic> audioItem;

  void gotoFocusPage() {
    Get.offNamed(Routes.focus);
  }

  void goBack() {
    Get.back();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    audioItem = Get.arguments[ArgumentKeys.audioItem];
    audioList = SPUtils.getInstance().getAudioList();
    await audioManager.init([audioItem]);
    audioManager.play();
    eventBus.on<AudioPlayCompleteEvent>().listen((final event) async {
      //音频播放完成
      gotoFocusPage();
      //休息次数+1
      SPUtils.getInstance()
          .setRestCount(restCount: SPUtils.getInstance().getRestCount() + 1);
      //记录专注&休息开始和结束时间
      SPUtils.getInstance().setRestStartTime(
        restStartTime: SPUtils.getInstance().getRestStartTimeTemp(),
      );
      SPUtils.getInstance().setRestEndTime(
        restEndTime: DateFormat('MM-dd HH:mm').format(DateTime.now()),
      );
    });
  }

  @override
  void onPaused() {
    // audioManager.stop();
    super.onPaused();
  }

  @override
  void onResumed() {
    // audioManager.play();
    super.onResumed();
  }

  @override
  void onClose() {
    audioManager.stop();
    super.onClose();
  }
}
