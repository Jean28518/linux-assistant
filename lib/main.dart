import 'package:flutter/material.dart';
import 'package:linux_helper/layouts/greeter/start_screen.dart';
import 'package:linux_helper/layouts/mintY.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    MintY.currentColor = Colors.blue;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StartScreen(),
    );
  }
}
