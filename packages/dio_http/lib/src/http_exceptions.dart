class HttpException implements Exception {
  final String? _message;

  // ignore: no_runtimetype_tostring
  String get message => _message ?? '$runtimeType';

  final dynamic _code;

  dynamic get code => _code ?? -1;

  HttpException([final this._message, final this._code]);

  @override
  String toString() => 'code:$code--message=$message';
}

/// 客户端请求错误
class BadRequestException extends HttpException {
  BadRequestException({final String? message, final code})
      : super(message, code);
}

/// 服务端响应错误
class BadServiceException extends HttpException {
  BadServiceException({final String? message, final code})
      : super(message, code);
}

class UnknownException extends HttpException {
  UnknownException([final String? message]) : super(message);
}

class CancelException extends HttpException {
  CancelException([final String? message]) : super(message);
}

class NetworkException extends HttpException {
  NetworkException({final String? message, final code}) : super(message, code);
}

/// 401
class UnauthorisedException extends HttpException {
  UnauthorisedException({final String? message, final code})
      : super(message, code);
}

class BadResponseException extends HttpException {
  dynamic data;

  BadResponseException([final this.data]) : super();
}
