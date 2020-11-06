import 'dart:async';
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
  final _controller = StreamController<Device>();
  @override
  void initState() {
    super.initState();
    _getDeviceInfo();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.close();
  }

  void _getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      _controller.add(Device(
        brand: androidInfo.manufacturer, //Samsung
        model: androidInfo.model, //SM-1234
        sdkVersion: androidInfo.version.sdkInt.toString(), //29
        version: 'Android ${androidInfo.version.release}', //Android 9
      ));
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      _controller.add(Device(
        brand: 'Apple',
        model: iosInfo.name,
        sdkVersion: iosInfo.systemVersion, //13.1
        version: '${iosInfo.systemName} ${iosInfo.systemVersion}', //iOS 13.1
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    _getDeviceInfo();
    return Scaffold(
      body: StreamBuilder<Device>(
          stream: _controller.stream,
          builder: (context, snapshot) {
            final brand = snapshot.data?.brand ?? '';
            final model = snapshot.data?.model ?? '';
            final sdkVersion = snapshot.data?.sdkVersion ?? '';
            final version = snapshot.data?.version ?? '';
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _item('brand:', brand),
                SizedBox(height: 16),
                _item('model:', model),
                SizedBox(height: 16),
                _item('sdkVersion:', sdkVersion),
                SizedBox(height: 16),
                _item('version:', version),
              ],
            );
          }),
    );
  }

  Widget _item(String title, String content) {
    return Row(children: [
      Text(title),
      Text(content),
    ]);
  }
}

class Device {
  final String brand;
  final String model;
  final String sdkVersion;
  final String version;

  Device({
    @required this.brand,
    @required this.model,
    @required this.sdkVersion,
    @required this.version,
  });
}
