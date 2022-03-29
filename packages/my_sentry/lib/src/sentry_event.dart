import 'package:sentry_flutter/sentry_flutter.dart';

Future<SentryEvent> sentryEvent({
  final String environment = 'event',
  final String eventMsg = '',
  final String routeName = '',
  final Map<String, dynamic> extra = const {},
}) async =>
    SentryEvent(
      environment: environment,
      message: SentryMessage(eventMsg),
      extra: extra,
      transaction: routeName,
      level: SentryLevel.info,
    );
