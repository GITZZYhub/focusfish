import 'package:event_bus/event_bus.dart';

final eventBusSticky = EventBus(); // 粘性事件，会等待事件创建再发送
final eventBus = EventBus(sync: true); // 直接发送