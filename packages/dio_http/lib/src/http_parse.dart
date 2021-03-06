// 成功回调
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:getx/getx.dart' hide Response;
import 'package:localization/localization.dart';

import '../dio_http.dart';
import 'default_http_transformer.dart';
import 'http_transformer.dart';

HttpResponse handleResponse(
  final Response<dynamic>? response, {
  HttpTransformer? httpTransformer,
}) {
  httpTransformer ??= DefaultHttpTransformer.getInstance();

  // 返回值异常
  if (response == null) {
    return HttpResponse.failureFromError();
  }

  // token失效
  if (_isTokenTimeout(response.statusCode)) {
    return HttpResponse.failureFromError(
      UnauthorisedException(
        message: AppLocalizations.of(Get.context!)!.unauthorized,
        code: response.statusCode,
      ),
    );
  }
  // 接口调用成功
  if (_isRequestSuccess(response.statusCode)) {
    return httpTransformer.parse(response);
  } else {
    // 接口调用失败
    return HttpResponse.failure(
      errorMsg: response.statusMessage,
      errorCode: response.statusCode,
    );
  }
}

HttpResponse handleException(final Exception exception) {
  final parseException = _parseException(exception);
  return HttpResponse.failureFromError(parseException);
}

/// 鉴权失败
bool _isTokenTimeout(final int? code) => code == 401;

/// 请求成功
bool _isRequestSuccess(final int? statusCode) =>
    statusCode != null && statusCode >= 200 && statusCode < 300;

HttpException _parseException(final Exception error) {
  if (error is DioError) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.sendTimeout:
        return NetworkException(
          message: AppLocalizations.of(Get.context!)!.socket_time_out_exception,
        );
      case DioErrorType.cancel:
        return CancelException(error.error.message);
      case DioErrorType.response:
        try {
          final errCode = error.response?.statusCode;
          switch (errCode) {
            case 400:
              return BadRequestException(
                message: AppLocalizations.of(Get.context!)!.invalid_request,
                code: errCode,
              );
            case 401:
              return UnauthorisedException(
                message: AppLocalizations.of(Get.context!)!.unauthorized,
                code: errCode,
              );
            case 403:
              return BadRequestException(
                message: AppLocalizations.of(Get.context!)!.request_rejected,
                code: errCode,
              );
            case 404:
              return BadRequestException(
                message: AppLocalizations.of(Get.context!)!.connect_exception,
                code: errCode,
              );
            case 405:
              return BadRequestException(
                message: AppLocalizations.of(Get.context!)!.request_rejected,
                code: errCode,
              );
            case 500:
              return BadServiceException(
                message: AppLocalizations.of(Get.context!)!.server_error,
                code: errCode,
              );
            case 502:
              return BadServiceException(
                message: AppLocalizations.of(Get.context!)!.invalid_request,
                code: errCode,
              );
            case 503:
              return BadServiceException(
                message: AppLocalizations.of(Get.context!)!.server_error,
                code: errCode,
              );
            case 505:
              return UnauthorisedException(
                message: AppLocalizations.of(Get.context!)!.invalid_request,
                code: errCode,
              );
            default:
              return UnknownException(error.error.message);
          }
        } on Exception catch (_) {
          return UnknownException(error.error.message);
        }

      case DioErrorType.other:
        if (error.error is SocketException) {
          return NetworkException(
            message: AppLocalizations.of(Get.context!)!.connect_exception,
          );
        } else {
          return UnknownException(error.message);
        }
      default:
        return UnknownException(error.message);
    }
  } else {
    return UnknownException(error.toString());
  }
}
