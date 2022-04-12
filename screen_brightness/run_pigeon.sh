flutter pub run pigeon \
  --input pigeons/messages.dart \
  --dart_out lib/messages.dart \
  --objc_header_out ios/Classes/messages.h \
  --objc_source_out ios/Classes/messages.m \
  --objc_prefix FLT \
  --java_out android/src/main/java/com/bwjh/screen_brightness/Messages.java \
  --java_package "com.bwjh.screen_brightness"