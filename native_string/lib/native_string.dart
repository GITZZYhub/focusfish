import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

const SENTRY_DSN = 0;
const SERVER_BASE_URL_DEV = 1;
const SERVER_BASE_URL_PROD = 2;

class NativeString {
  static String getString(final int code) {
    final nativeStringLib = Platform.isAndroid
        ? DynamicLibrary.open('libnative_string.so')
        : DynamicLibrary.process();

    // ignore: omit_local_variable_types
    final Pointer<Utf8> Function(int code) nativeString = nativeStringLib
        .lookup<NativeFunction<Pointer<Utf8> Function(Int32 code)>>(
      'get_native_string',
    )
        .asFunction();

    return nativeString(code).toDartString();
  }
}
