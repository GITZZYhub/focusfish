import 'package:flutter/material.dart';
import 'package:flukit/flukit.dart';

class PhotoViewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Swiper(
      autoStart: false,
      circular: true,
      indicator: CircleSwiperIndicator(
        padding: EdgeInsets.only(bottom: 30.0),
        itemColor: Colors.black26,
      ),
      children: <Widget>[
        Image.asset('assets/images/', package: 'resources', fit: BoxFit.fill),
        Image.asset('assets/images/', package: 'resources', fit: BoxFit.fill),
        Image.asset('assets/images/', package: 'resources', fit: BoxFit.fill),
      ].map((v) {
        return ScaleView(child: v);
      }).toList(),
    );
  }
}
