import 'dart:async';
import 'dart:ffi';

import 'package:alewilapp/models/shop_price.dart';
import 'package:alewilapp/services/animal_service.dart';
import 'package:alewilapp/services/prices_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PricesTableWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PricesTableWidgetState();
  }
}

class _PricesTableWidgetState extends State<PricesTableWidget> {
  List<ShopPrice>? prices;
  var isLoaded = false;

  var currentAnimal = AnimalService().GetAnimal();

  @override
  void initState() {
    super.initState();
    getData();
  }

  @mustCallSuper
  @override
  void didUpdateWidget(PricesTableWidget widget) {
    super.didUpdateWidget(widget);

    var newAnimal = AnimalService().GetAnimal();

    if (currentAnimal != newAnimal) {
      currentAnimal = newAnimal;
      getData();
    }
  }

  getData() async {
    print("fethcing");

    var newPrices = await PricesService().getPrices();

    setState(() {
      prices = newPrices;
    });

    if (newPrices != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  Color? getColor(int index) {
    var firstPrice = prices![index].product.price;
    var smallestPrice = prices![0].product.price;

    for (int i = 0; i < prices!.length; i++) {
      if (smallestPrice > prices![i].product.price) {
        smallestPrice = prices![i].product.price;
      }
    }

    return firstPrice <= smallestPrice ? Colors.lightGreen : null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Stack(children: [
        Visibility(
            visible: isLoaded,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: ListView.builder(
              itemCount: prices?.length,
              itemBuilder: (context, index) {
                return Container(
                  color: getColor(index),
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(prices![index].name),
                      Text(prices![index].product.name),
                      Text(prices![index]
                              .product
                              .price
                              .roundToDouble()
                              .toString() +
                          ' zł')
                    ],
                  ),
                );
              },
            )),
        Center(
          child: TextButton.icon(
            onPressed: () {
              print('object');
              setState(() {
                isLoaded = false;
              });
              getData();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Odśwież listę'),
          ),
        ),
      ]),
    );
  }
}
