import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main(List<String> args) {
  runApp(
   const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
    ),
  );
}