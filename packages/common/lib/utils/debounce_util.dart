import 'dart:async';

import 'package:flutter/material.dart';

class DebounceInstance {
  // 单例公开访问点
  factory DebounceInstance() => DebounceInstance.getInstance();

  // 静态私有成员，没有初始化
  static DebounceInstance? _instance;

  // 私有构造函数
  DebounceInstance._() {
    // 具体初始化代码
  }

  // 静态、同步、私有访问点
  DebounceInstance.getInstance() {
    _instance ??= DebounceInstance._();
    _instance!;
  }

  bool isFastClicks = false;

  ///科学防抖,在指定时间内，只响应第一次的事件
  VoidCallback? clickDebounce(final Function? fn, [final int t = 300]) => () {
        if (!isFastClicks) {
          isFastClicks = true;
          fn!();
          Future.delayed(Duration(milliseconds: t), () {
            isFastClicks = false;
          });
        }
      };

  ///取消定时器
  void cancelTime() {
    isFastClicks = false;
  }
}
