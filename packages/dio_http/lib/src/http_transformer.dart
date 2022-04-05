import '../dio_http.dart';

/// Response 解析
typedef Parse = HttpResponse Function(Response<dynamic> response);

abstract class HttpTransformer {
  Parse get parse;
}
