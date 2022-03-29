import 'dart:async';

import 'package:dio/dio.dart';

typedef RetryEvaluator = FutureOr<bool> Function(DioError error);

const retryCount = 3;

class RetryOptions {
  /// 可切换url列表的mmkv的key
  final String? configUrlKey;

  /// The number of retry in case of an error
  final int? retries;

  /// The interval before a retry.
  final Duration? retryInterval;

  /// Evaluating if a retry is necessary.regarding the error.
  ///
  /// It can be a good candidate for additional operations too, like
  /// updating authentication token in case of a unauthorized error (be careful
  /// with concurrency though).
  ///
  /// Defaults to [defaultRetryEvaluator].
  RetryEvaluator get retryEvaluator => _retryEvaluator ?? defaultRetryEvaluator;

  final RetryEvaluator? _retryEvaluator;

  const RetryOptions({
    final this.retries = retryCount,
    final RetryEvaluator? retryEvaluator,
    final this.retryInterval = const Duration(seconds: 1),
    final this.configUrlKey,
  }) : _retryEvaluator = retryEvaluator;

  factory RetryOptions.noRetry() => const RetryOptions(
        retries: 0,
      );

  static const extraKey = 'cache_retry_request';

  /// Returns true only if the response hasn't been cancelled or got
  /// a bas status code.
  static FutureOr<bool> defaultRetryEvaluator(final DioError error) =>
      error.type != DioErrorType.cancel && error.type != DioErrorType.response;

  static RetryOptions? fromExtra(final RequestOptions request) =>
      request.extra[extraKey];

  RetryOptions copyWith({
    final int? retries,
    final Duration? retryInterval,
    final String? configUrlKey,
  }) =>
      RetryOptions(
        retries: retries ?? this.retries,
        retryInterval: retryInterval ?? this.retryInterval,
        configUrlKey: configUrlKey ?? this.configUrlKey,
      );

  Map<String, dynamic> toExtra() => {
        extraKey: this,
      };

  Options toOptions() => Options(extra: toExtra());

// Options mergeIn(Options options) {
//   return options.merge(
//       extra: <String,dynamic>{}
//         ..addAll(options.extra ?? {})
//         ..addAll(this.toExtra())
//   );
// }
}
