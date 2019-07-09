import 'package:event_bus/event_bus.dart';
import 'package:flutter_netease_cloud/utils/http_manager/http_manager.dart';
class Application {
  static final EventBus errorHandlerEvent = new EventBus();
  static final HttpManager httpManager = new HttpManager();
}