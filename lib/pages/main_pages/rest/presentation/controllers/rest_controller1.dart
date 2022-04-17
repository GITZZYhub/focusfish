import 'dart:async';

import 'package:common/audio_services/audio_manager.dart';
import 'package:common/constants/argument_keys.dart';
import 'package:common/controller/base_controller.dart';
import 'package:common/event/audio_play_complete.dart';
import 'package:common/event/init_audio_manager.dart';
import 'package:eventbus/eventbus.dart';
import 'package:getx/getx.dart';

import '../../../../../routes/app_pages.dart';
import '../../rest.dart';

class RestController extends BaseController {
  RestController({required final this.restRepository});

  final IRestRepository restRepository;

  final AudioManager audioManager = Get.find<AudioManager>();

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
    audioManager.playFromMediaId(audioItem['title']);
    eventBus.on<AudioPlayCompleteEvent>().listen((final event) async {
      //音频播放完成
      if(!isClosed){
        gotoFocusPage();
      }
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
    eventBus.fire(InitAudioManagerEvent());
    super.onClose();
  }
}
