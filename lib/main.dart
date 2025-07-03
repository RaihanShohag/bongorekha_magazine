import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const BongorekhaApp());
}

class BongorekhaApp extends StatelessWidget {
  const BongorekhaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bongorekha Magazine',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}
