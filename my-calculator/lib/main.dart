import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_calculator/calculator_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Calculator',
      theme: ThemeData.dark(),
      home: const CalculatorScreen(),
    );
  }
}