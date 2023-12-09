import 'dart:convert';

import 'package:chef_connect_project/FoodItemCategories/ProductCategories.dart';

class DefaultFood {
  bool error;
  String message;
  Data data;

  DefaultFood({
    required this.error,
    required this.message,
    required this.data,
  });

  factory DefaultFood.fromJson(Map<String, dynamic> json) => DefaultFood(
        error: json["error"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  List<Product> products;

  Data({
    required this.products,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  String name;
  int barcode;
  int id;
  String imageUrl;
  double rate;
  int time;
  int unitId;
  int quantity;

  Product({
    required this.name,
    required this.barcode,
    required this.id,
    required this.imageUrl,
    required this.rate,
    required this.time,
    required this.unitId,
    required this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      name: json["name"],
      barcode: json["barcode"],
      id: json["id"],
      imageUrl: json["image_url"],
      rate: json["rate"],
      time: json["time"] ?? "",
      unitId: json["UnitID"],
      quantity: productQuantity);

  Map<String, dynamic> toJson() => {
        "name": name,
        "barcode": barcode,
        "id": id,
        "image_url": imageUrl,
        "rate": rate,
        "time": time,
        "UnitID": unitId,
        "quantity": quantity
      };
}

/////////////////////////////specification/////////////////////////

Specification specificationFromJson(String str) =>
    Specification.fromJson(json.decode(str));

String specificationToJson(Specification data) => json.encode(data.toJson());

class Specification {
  bool error;
  String message;
  Datas data;

  Specification({
    required this.error,
    required this.message,
    required this.data,
  });

  factory Specification.fromJson(Map<String, dynamic> json) => Specification(
        error: json["error"] ?? false,
        message: json["message"] ?? "",
        data: Datas.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data.toJson(),
      };
}

class Datas {
  List<Products> products;

  Datas({
    required this.products,
  });

  factory Datas.fromJson(Map<String, dynamic> json) => Datas(
        products: List<Products>.from(
            json["products"].map((x) => Products.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Products {
  String name;
  int barcode;
  int id;
  String imageUrl;
  double rate;
  String specification;
  int unitId;

  Products({
    required this.name,
    required this.barcode,
    required this.id,
    required this.imageUrl,
    required this.rate,
    required this.specification,
    required this.unitId,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        name: json["name"],
        barcode: json["barcode"],
        id: json["id"],
        imageUrl: json["image_url"],
        rate: json["rate"],
        specification: json["Specification"],
        unitId: json["UnitID"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "barcode": barcode,
        "id": id,
        "image_url": imageUrl,
        "rate": rate,
        "Specification": specification,
        "UnitID": unitId,
      };
}
