import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as p;

class MultipartFileExtended extends MultipartFile {
  final String? filePath; //this one!

  MultipartFileExtended(
    final Stream<List<int>> stream,
    final length, {
    final filename,
    final this.filePath,
    final contentType,
  }) : super(stream, length, filename: filename, contentType: contentType);

  static MultipartFileExtended fromFileSync(
    final String filePath, {
    final String? filename,
    final MediaType? contentType,
  }) =>
      multipartFileFromPathSync(
        filePath,
        filename: filename,
        contentType: contentType,
      );
}

MultipartFileExtended multipartFileFromPathSync(
  final String filePath, {
  String? filename,
  final MediaType? contentType,
}) {
  filename ??= p.basename(filePath);
  final file = File(filePath);
  final length = file.lengthSync();
  final stream = file.openRead();
  return MultipartFileExtended(
    stream,
    length,
    filename: filename,
    contentType: contentType,
    filePath: filePath,
  );
}
