import 'package:flutter/material.dart';

class GetxLogger {
  // Sample of abstract logging function
  static void write(final String text, {final bool isError = false}) {
    Future.microtask(() => debugPrint('** $text. isError: [$isError]'));
  }
}
