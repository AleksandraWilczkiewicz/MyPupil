import 'dart:developer';

import 'package:alewilapp/screens/create.dart';
import 'package:alewilapp/screens/prices-screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../components/prices-table.dart';
import '../services/animal_service.dart';

class MainScreenWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainScreenWidgetState();
  }
}

void _navigateToNextScreen(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => CreateWidget()));
}

void _navigateToPricesTables(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => PricesScreenWidget()));
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(
      builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text('Mój pupil'),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                _navigateToNextScreen(context);
              },
              child: const Icon(Icons.add)),
          body: Scaffold(
            body: Container(
              child: Center(
                child: ElevatedButton(
                  onPressed: () => _navigateToPricesTables(context),
                  child: Container(
                      color: Theme.of(context).primaryColor,
                      width: 400,
                      height: 400,
                      child: Stack(
                        children: [
                          Center(
                              child: Stack(
                                children: [
                                  Center(
                                    child: Text("Sprawdź ceny karmy", style: TextStyle(fontSize: 34, color: Colors.white),),
                                  ),
                                ],
                              )
                          )
                        ],
                      )
                  ),
                )
              ),
            ),
          )),
    ));
  }
}
