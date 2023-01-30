import 'package:flutter/material.dart';

import '../components/prices-table.dart';

class PricesScreenWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PricesScreenWidgetState();
  }
}

class _PricesScreenWidgetState extends State<PricesScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(
          builder: (context) => Scaffold(
              appBar: AppBar(
                title: Text('Mój pupil'),
              ),
              body: Scaffold(
                body: Container(
                  child: Center(
                    child: PricesTableWidget(),
                  ),
                ),
              )),
        ));
  }
}
