import 'logger_ext.dart';
import 'logger_title.dart';

///===================== permisions =======================================///
void logPermissionsInfo({
  required final String info,
  required final bool needStack,
}) {
  if (needStack) {
    logger.i('${LoggerTitle.permission}==> $info');
  } else {
    loggerNoStack.i('${LoggerTitle.permission}==> $info');
  }
}

///===================== end =======================================///

///===================== localization =======================================///
void logLocalizationInfo({
  required final String info,
  required final bool needStack,
}) {
  if (needStack) {
    logger.i('${LoggerTitle.localization}==> $info');
  } else {
    loggerNoStack.i('${LoggerTitle.localization}==> $info');
  }
}

///===================== end =======================================///

///===================== common =======================================///
void logCommonInfo({
  required final String info,
  required final bool needStack,
}) {
  if (needStack) {
    logger.i('${LoggerTitle.common}==> $info');
  } else {
    loggerNoStack.i('${LoggerTitle.common}==> $info');
  }
}

void logCommonError({
  required final String error,
  required final bool needStack,
}) {
  if (needStack) {
    logger.e('${LoggerTitle.common}==> $error');
  } else {
    loggerNoStack.e('${LoggerTitle.common}==> $error');
  }
}

///===================== end =======================================///

///===================== http =======================================///
void logHttpInfo({
  required final String info,
  required final bool needStack,
}) {
  if (needStack) {
    logger.i('${LoggerTitle.http}==> $info');
  } else {
    loggerNoStack.i('${LoggerTitle.http}==> $info');
  }
}

void logHttpError({
  required final String error,
  required final bool needStack,
}) {
  if (needStack) {
    logger.e('${LoggerTitle.http}==> $error');
  } else {
    loggerNoStack.e('${LoggerTitle.http}==> $error');
  }
}

///===================== end =======================================///

///===================== database =======================================///
void logDatabaseInfo({
  required final String info,
  required final bool needStack,
}) {
  if (needStack) {
    logger.i('${LoggerTitle.database}==> $info');
  } else {
    loggerNoStack.i('${LoggerTitle.database}==> $info');
  }
}

void logDatabaseError({
  required final String error,
  required final bool needStack,
}) {
  if (needStack) {
    logger.e('${LoggerTitle.database}==> $error');
  } else {
    loggerNoStack.e('${LoggerTitle.database}==> $error');
  }
}

///===================== end =======================================///