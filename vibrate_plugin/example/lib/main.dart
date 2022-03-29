import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:vibrate_plugin/messages.dart';
import 'package:vibrate_plugin/vibrate_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _canVibrate = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    bool canVibrate;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      canVibrate = await VibratePlugin.canVibrate;
    } on PlatformException {
      canVibrate = false;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _canVibrate = canVibrate;
    });
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('canVibrate: $_canVibrate\n'),
            ElevatedButton(
              onPressed: () {
                VibratePlugin.vibrateWithPauses([
                  const Duration(milliseconds: 100),
                  const Duration(milliseconds: 300),
                  const Duration(milliseconds: 500)
                ]);
              },
              child: const Text('vibrate'),
            ),
            ElevatedButton(
              onPressed: () {
                VibratePlugin.feedback(FeedbackType.error);
              },
              child: const Text('feedback'),
            ),
          ],
        ),
      ),
    ),
  );
}
