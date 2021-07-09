import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List _productList;
List _candyList;

class PieData {
  static List<Data> data = [
    Data(name: 'Candies', percent: 20, color: Colors.pink[600]),
    Data(name: 'Drinks', percent: 10, color: Colors.orange[400]),
    Data(name: 'Nuts', percent: 20, color: Colors.teal[400]),
    Data(name: 'Plums', percent: 20, color: Colors.indigo[600]),
    Data(name: 'Snacks', percent: 20, color: Colors.purple),
    Data(name: 'Toys', percent: 20, color: Colors.black),
  ];
}

class Data {
  final String name;

  final double percent;

  final Color color;

  Data({this.name, this.percent, this.color});
}

int _loadproducts() {
  http.post(
      Uri.parse(
          "https://hubbuddies.com/270607/snackeverywhere/php/loadProductsCategory.php"),
      body: {"product_cat": "All"}).then((response) {
    print(response.body);
    if (response.body == "nodata") {
      return _productList.length;
    } else {
      var jsondata = json.decode(response.body);
      _productList = jsondata["products"];
      print(_productList.length);
      return _productList.length;
    }
  });
  return _productList.length;
}

int _loadcandyproducts() {
  http.post(
      Uri.parse(
          "https://hubbuddies.com/270607/snackeverywhere/php/loadProductsCategory.php"),
      body: {"product_cat": "candy"}).then((response) {
    print(response.body);
    if (response.body == "nodata") {
      return 0;
    } else {
      var jsondata = json.decode(response.body);
      _productList = jsondata["products"];
      print(_candyList.length);
      return _candyList.length;
    }
  });
  return _candyList.length;
}

double calculationcandy() {
  int allitem=_loadproducts();
  int candyitem=_loadcandyproducts();
  double candypercent = (allitem / candyitem) * 100;
  return candypercent.roundToDouble();
}
