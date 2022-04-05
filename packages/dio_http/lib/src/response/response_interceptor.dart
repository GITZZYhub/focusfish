import 'package:getx/getx.dart' hide Response;
import 'package:localization/localization.dart';
import 'package:my_logger/my_logger.dart';

import '../../dio_http.dart';
import '../app_dio.dart';
import 'response_code.dart';
import 'result_response.dart';

class ResponseInterceptor extends Interceptor {
  @override
  Future<void> onResponse(
    final Response<dynamic> response,
    final ResponseInterceptorHandler handler,
  ) async {
    var responseCode = response.data['code'];
    var responseCodeDesc = response.data['codeDesc'];
    final responseData = response.data['data'];
    if (responseCode != null) {
      // 响应结果含有code
      if (responseCode == ServerCode.success) {
        // 响应成功
        _parseResponse(
          response,
          ResponseCode.success,
          responseData,
          responseCodeDesc,
        );
      } else {
        // 响应失败
        final String? codeUrl = response.data['codeUrl'];
        if (codeUrl == null || codeUrl.isEmpty) {
          _parseResponse(
            response,
            responseCode,
            null,
            responseCodeDesc,
          );
        } else {
          await _getServerError(
            response,
            codeUrl,
            responseCode,
            responseCodeDesc,
          );
        }
      }
    } else {
      // 响应结果含有result
      responseCode = response.data['result']['code'];
      responseCodeDesc = response.data['result']['codeDesc'];

      if (responseCode == ServerCode.success) {
        // 响应成功
        _parseResponse(
          response,
          ResponseCode.success,
          responseData,
          responseCodeDesc,
        );
      } else {
        // 响应失败
        final String? codeUrl = response.data['result']['codeUrl'];
        if (codeUrl == null || codeUrl.isEmpty) {
          _parseResponse(
            response,
            responseCode,
            null,
            responseCodeDesc,
          );
        } else {
          await _getServerError(
            response,
            codeUrl,
            responseCode,
            responseCodeDesc,
          );
        }
      }
    }
    handler.next(response);
  }

  void _parseResponse(
    final Response<dynamic> response,
    final code,
    final responseData,
    final String message,
  ) {
    final data = responseData ?? response.data;
    final resultResponse = ResultResponse(code, message, data);
    response.data = resultResponse.toJson((final value) => data);
  }

  /// 获取国际化错误信息
  Future<void> _getServerError(
    final Response<dynamic> response,
    final String requestUrl,
    final code,
    final String message,
  ) async {
    final errorQueryParameters = {
      'lang': getCurrentServerLanguage(Get.context!),
    };
    logHttpInfo(info: '获取国际化错误信息: $requestUrl', needStack: false);
    await _dioRequest(response, requestUrl, errorQueryParameters)
        .then((final resp) {
      if (resp.data['result']['code'] == ServerCode.success) {
        _parseResponse(response, code, null, resp.data['data']['content']);
      } else {
        _parseResponse(response, code, null, message);
      }
    }).catchError((final error) {
      _parseResponse(response, code, null, message);
    });
  }

  /// 国际化请求
  Future<Response<dynamic>> _dioRequest(
    final Response<dynamic> response,
    final String url,
    final Map<String, dynamic> errorQueryParameters,
  ) async {
    final dio = AppDio();
    return dio.get(
      url,
      cancelToken: response.requestOptions.cancelToken,
      queryParameters: errorQueryParameters,
    );
  }
}
