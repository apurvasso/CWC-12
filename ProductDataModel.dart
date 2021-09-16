import 'package:flutter/material.dart';

class ProductDataModel {
  ProductDataModel(@required this.open, @required this.close,
      @required this.low, @required this.high, @required this.date);
  num? open;
  num? close;
  num? low;
  num? high;
  DateTime? date;
  ProductDataModel.fromJason(Map<String, dynamic> json) {
    open = json['open'];
    close = json['close'];
    low = json['low'];
    high = json['high'];
    date = json['date'];
  }
}
