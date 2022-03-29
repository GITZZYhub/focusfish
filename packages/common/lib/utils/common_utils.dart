import 'dart:math';
import 'dart:ui';

///获取随机颜色
Color getRandomColor(Random random) {
  var a = random.nextInt(255);
  var r = random.nextInt(255);
  var g = random.nextInt(255);
  var b = random.nextInt(255);
  return Color.fromARGB(a, r, g, b);
}

///获取随机透明的白色
Color getRandomWhiteColor(Random random) {
  //0~255 0为完全透明 255 为不透明
  //这里生成的透明度取值范围为 10~200
  int a = random.nextInt(190) + 10;
  return Color.fromARGB(a, 255, 255, 255);
}

///计算坐标
Offset calculateXY(double speed, double theta) {
  return Offset(speed * cos(theta), speed * sin(theta));
}