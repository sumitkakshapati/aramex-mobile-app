import 'package:flutter/material.dart';

class ChartData<T> {
  String title;
  int value;
  Color color;
  T? type;

  ChartData({
    required this.title,
    required this.value,
    required this.color,
    this.type,
  });
}
