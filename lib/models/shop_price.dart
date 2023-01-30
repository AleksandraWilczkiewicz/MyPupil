// To parse this JSON data, do
//
//     final shopPrice = shopPriceFromJson(jsonString);

import 'dart:convert';

List<ShopPrice> shopPriceFromJson(String str) => List<ShopPrice>.from(json.decode(str).map((x) => ShopPrice.fromJson(x)));

String shopPriceToJson(List<ShopPrice> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShopPrice {
  ShopPrice({
    required this.name,
    required this.product,
  });

  String name;
  Product product;

  factory ShopPrice.fromJson(Map<String, dynamic> json) => ShopPrice(
    name: json["Name"],
    product: Product.fromJson(json["Product"]),
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "Product": product.toJson(),
  };
}

class Product {
  Product({
    required this.name,
    required this.price,
  });

  String name;
  double price;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    name: json["Name"],
    price: json["Price"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "Price": price,
  };
}
