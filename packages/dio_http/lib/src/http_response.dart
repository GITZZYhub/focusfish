import 'http_exceptions.dart';

class HttpResponse {
  late bool ok;
  dynamic data;
  HttpException? error;

  HttpResponse.success(this.data) {
    ok = true;
  }

  HttpResponse.failure({final String? errorMsg, final errorCode}) {
    error = BadRequestException(message: errorMsg, code: errorCode);
    ok = false;
  }

  HttpResponse.failureFormResponse({final data}) {
    error = BadResponseException(data);
    ok = false;
  }

  HttpResponse.failureFromError([final HttpException? error]) {
    this.error = error ?? UnknownException();
    ok = false;
  }
}
