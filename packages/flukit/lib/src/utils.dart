bool isListEqual(final List<dynamic>? a, final List<dynamic>? b) {
  if (a == b) {
    return true;
  }
  if (a == null || b == null || a.length != b.length) {
    return false;
  }
  var i = 0;
  return a.every((final e) => b[i++] == e);
}
