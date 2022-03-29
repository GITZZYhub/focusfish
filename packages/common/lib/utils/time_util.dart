class TimeUtil {
  static int currentTimeMillis() => DateTime.now().millisecondsSinceEpoch;

  static String convertTime(final minutes, final seconds) {
    String twoDigits(final int n) => n.toString().padLeft(2, '0');
    final twoDigitMinutes = twoDigits(minutes.remainder(60));
    final twoDigitSeconds = twoDigits(seconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  static String convertTimeToText(final minutes, final seconds) {
    if (minutes == 0) {
      return '$seconds秒';
    }
    return '$minutes分$seconds秒';
  }
}
