import 'package:common/controller/base_controller.dart';
import 'package:common/utils/sp_utils/sp_utils.dart';
import 'package:my_logger/my_logger.dart';
import 'package:permissions/request_permissions.dart';

class FlashController extends BaseController {
  bool isFirstEnter = false;

  @override
  void onInit() {
    super.onInit();
    isFirstEnter = SPUtils.getInstance().getFirstEnterState();
    logCommonInfo(
      info: '闪屏页面初始化成功，初始状态：${isFirstEnter ? "欢迎页面" : "启动页面"}',
      needStack: false,
    );
    RequestPermission.request().then((final allPermissionsGranted) {
      if (!allPermissionsGranted) {
        //TODO message 处理缺少权限的情况，注意如果用户在此处拒绝，当下次使用相关权限的时候务必再次单独申请,
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
