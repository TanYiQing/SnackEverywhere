import 'package:flutter/material.dart';

class PieData {
  static List<Data> data = [
    Data(name: 'Candies',percent: 20, color: Colors.pink[600]),
    Data(name: 'Drinks', percent: 20, color: Colors.orange[400]),
    Data(name: 'Nuts', percent: 20, color: Colors.teal[400]),
    Data(name: 'Plums', percent: 20, color: Colors.indigo[600]),
    Data(name: 'Snacks', percent: 10, color: Colors.purple),
    Data(name: 'Toys', percent: 10, color: Colors.black),
  ];
}

class Data {
  final String name;

  final double percent;

  final Color color;

  Data({this.name, this.percent, this.color});
}