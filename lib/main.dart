import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String brand = '';
  String model = '';
  String sdkVersion = '';
  String version = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDeviceInfo();
  }

  void _getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();

    if(Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      brand = '';
      model = '';
      sdkVersion = '';
      version = '';
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      brand = '';
      model = '';
      sdkVersion = '';
      version = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _item('brand:', brand),
          SizedBox(height: 16),
          _item('model:', model),
          SizedBox(height: 16),
          _item('sdkVersion:', sdkVersion),
          SizedBox(height: 16),
          _item('version:', version),
        ],
      ),
    );
  }

  Widget _item(String title, String content) {
    return Row(children: [
      Text(title),
      Text(content),
    ]);
  }
}
