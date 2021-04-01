import 'package:flutter/material.dart';

class CustomTab extends Tab {
  final String title;
  CustomTab({this.title}) : super(child: Text(title));
}
