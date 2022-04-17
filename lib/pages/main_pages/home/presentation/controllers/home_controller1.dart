import 'package:common/audio_services/audio_manager.dart';
import 'package:common/controller/base_controller.dart';
import 'package:common/event/init_audio_manager.dart';
import 'package:common/utils/sp_utils/sp_utils.dart';
import 'package:eventbus/eventbus.dart';
import 'package:getx/getx.dart';
import 'package:local_notification/local_notification.dart';
import 'package:resources/resources.dart';

import '../../../../../routes/app_pages.dart';
import '../../home.dart';

class HomeController extends BaseController {
  HomeController({required final this.homeRepository});

  final IHomeRepository homeRepository;

  final AudioManager audioManager = Get.find<AudioManager>();
  late final List<dynamic> audioList;

  final tabs = ['工作鱼', '学习鱼', '冥想鱼', '任意鱼'];
  final tabImgs = [R.png.working, R.png.learning, R.png.thinking, R.png.free];
  final tabIndex = 0.obs;

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
  Future<void> onInit() async {
    super.onInit();
    audioList = SPUtils.getInstance().getAudioList();
    await audioManager.init(audioList);
    eventBus.on<InitAudioManagerEvent>().listen((final event) async {
      //从休息页返回需要重新加载资源，否则下次播放会有缓冲
      await audioManager.init(audioList);
    });
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    //开启通知监听
    NotificationService().configureSelectNotificationSubject((final payload) {
      // 当用户点击通知会回调此方法
    });
  }

  @override
  void onClose() {
    NotificationService().dispose();
    audioManager.dispose();
    super.onClose();
  }
}
