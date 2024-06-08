import 'package:flutter/material.dart';
import 'package:turismo_qapp/screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Turismo Qapp',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
