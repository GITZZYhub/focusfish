import '../../dio_http.dart';
import 'response/response_code.dart';

class DefaultHttpTransformer extends HttpTransformer {
  @override
  Parse get parse => _parse;

  HttpResponse _parse(final Response<dynamic> response) {
    if (response.data['code'] == ResponseCode.success) {
      return HttpResponse.success(response.data['data']);
    } else {
      return HttpResponse.failure(
        errorMsg: response.data['message'],
        errorCode: response.data['code'],
      );
    }
  }

  /// 单例对象
  static final DefaultHttpTransformer _instance =
      DefaultHttpTransformer._internal();

  /// 内部构造方法，可避免外部暴露构造函数，进行实例化
  DefaultHttpTransformer._internal();

  /// 工厂构造方法，这里使用命名构造函数方式进行声明
  factory DefaultHttpTransformer.getInstance() => _instance;
}
