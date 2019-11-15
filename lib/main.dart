import 'package:flutter/material.dart';

import './dashboard.dart';

void main() {
  runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "chickfights",
      theme: ThemeData(
          primarySwatch: Colors.pink,
      ),
      home: Dashboard()
  ));
}