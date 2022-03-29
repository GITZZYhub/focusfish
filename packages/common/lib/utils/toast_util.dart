import 'package:dio_http/dio_http.dart' show HttpException;
import 'package:flutter/material.dart';
import 'package:getx/getx.dart';
import 'package:my_logger/my_logger.dart';

void showToast(final String toastMsg) {
  ScaffoldMessenger.of(Get.context!).showSnackBar(
    SnackBar(
      content: Text(toastMsg),
      duration: const Duration(milliseconds: 2500),
      behavior: SnackBarBehavior.fixed,
    ),
  );
}

void showNetworkToast(
  // ignore: type_annotate_public_apis
  final error,
) {
  if (error is HttpException) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text('${error.message}(${error.code})'),
        duration: const Duration(milliseconds: 2500),
        behavior: SnackBarBehavior.fixed,
      ),
    );
  }
}
