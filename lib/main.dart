import 'dart:async';
import 'dart:developer';

import 'package:alewilapp/api/notification_api.dart';
import 'package:alewilapp/screens/choose-animal.dart';
import 'package:alewilapp/screens/create.dart';
import 'package:alewilapp/services/animal_service.dart';
import 'package:flutter/material.dart';
import 'package:light/light.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'components/prices-table.dart';

const api = 'https://fakeshopapi.lm.r.appspot.com/prices';
const luxThreshold = 100;

void main() {
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  String _luxString = 'Unknown';
  late Light _light;
  late StreamSubscription _subscription;
  late int LuxValue = 15;



  void onData(int luxValue) async {
    setState(() {
      _luxString = "$luxValue";
      LuxValue = luxValue;
    });
  }

  void stopListening() {
    _subscription.cancel();
  }

  void startListening() {
    _light = new Light();
    try {
      _subscription = _light.lightSensorStream.listen(onData);
    } on LightException catch (exception) {
      print(exception);
    }
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    startListening();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primarySwatch: LuxValue >= luxThreshold ? Colors.blue : Colors.deepPurple,
            backgroundColor:
                LuxValue >= luxThreshold ? Colors.white10 : Colors.purple[200]!,
            textTheme: TextTheme(
                bodyText1: TextStyle(
                    color: LuxValue >= luxThreshold
                        ? Colors.black
                        : Colors.white))),
        home: Builder(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text('Mój pupil'),
            ),
            // floatingActionButton: FloatingActionButton(
            //     onPressed: () {
            //       _navigateToNextScreen(context);
            //     },
            //     child: const Icon(Icons.add)),
            body: Scaffold(
              body: ChooseAnimalWidget(),
            )
          ),
        ));
  }
}
