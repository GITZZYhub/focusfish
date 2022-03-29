import 'package:dio_http/dio_http.dart';
import 'package:getx/getx.dart';

import 'debounce_util.dart';

HttpClient httpClient = Get.find<HttpClient>();
DebounceInstance clickDebounce = DebounceInstance();