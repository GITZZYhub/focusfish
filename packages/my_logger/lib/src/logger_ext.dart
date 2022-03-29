import 'package:logger/logger.dart';

Logger logger = Logger(
  printer: PrettyPrinter(
    printTime: true,
  ),
);

Logger loggerNoStack = Logger(
  printer: PrettyPrinter(
    methodCount: 1,
    printTime: true,
  ),
);
