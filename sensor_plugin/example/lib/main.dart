import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:sensor_plugin/sensor_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSensorAvailable = false;
  late StreamSubscription<dynamic> _streamSubscription;
  double _angleX = 0;
  double _angleY = 0;

  @override
  void initState() {
    super.initState();
    init();

    _streamSubscription = SensorPlugin.stream().listen((event) {
      setState(() {
        _angleX = jsonDecode(event)['X'].toDouble();
        _angleY = jsonDecode(event)['Y'].toDouble();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  Future<void> init() async {
    bool isSensorAvailable;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      isSensorAvailable = await SensorPlugin.isSensorAvailable;
    } on PlatformException {
      isSensorAvailable = false;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _isSensorAvailable = isSensorAvailable;
    });
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: Text(
            'isSensorAvailable: $_isSensorAvailable\n$_angleX, $_angleY'),
      ),
    ),
  );
}
