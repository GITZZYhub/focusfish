import 'package:carousel_slider/carousel_slider.dart';
import 'package:common/audio_services/audio_manager.dart';
import 'package:common/constants/argument_keys.dart';
import 'package:common/constants/contants_value.dart';
import 'package:common/controller/base_controller.dart';
import 'package:common/event/show_add_coins_dialog_event.dart';
import 'package:common/utils/sp_utils/sp_utils.dart';
import 'package:common/widgets/coins_statement_dialog.dart';
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

  final CarouselController carouselController = CarouselController();

  final tabs = ['工作鱼', '学习鱼', '冥想鱼', '任意鱼'];
  final tabImgs = [R.png.working, R.png.learning, R.png.thinking, R.png.free];
  final initPageIndex = 3;
  final tabIndex = 3.obs;

  final coins = 0.obs;

  void gotoFocusPage() {
    final arguments = {
      ArgumentKeys.focusFadeImage: tabImgs[tabIndex.value],
    };
    Get.toNamed(Routes.focus, arguments: arguments);
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
    coins.value = SPUtils.getInstance().getCoins();
    eventBus.on<ShowAddCoinsDialogEvent>().listen((final event) async {
      final restCount = SPUtils.getInstance().getRestCount();
      // 清空记录的休息次数
      SPUtils.getInstance().setRestCount(restCount: 0);
      await Future<dynamic>.delayed(const Duration(milliseconds: 800));
      await getCoinsStatementDialog(
        context: Get.context!,
        restCount: restCount,
        restStartTime: SPUtils.getInstance().getRestStartTime(),
        restEndTime: SPUtils.getInstance().getRestEndTime(),
      ).show().then((final value) {
        // 增加已获得的金币数目
        SPUtils.getInstance().setCoins(
          coins:
              SPUtils.getInstance().getCoins() + restCount * Constants.coinPer,
        );
        coins.value = SPUtils.getInstance().getCoins();
      });
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
    audioManager.stop();
    NotificationService().dispose();
    super.onClose();
  }
}
