import 'package:flutter/material.dart';
import 'package:my_cash_book/screens/login.dart';
// import 'package:my_cash_book/screens/beranda.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'BKN Apps',
      home: HalamanLogin(title: 'BKN Apps'),
      debugShowCheckedModeBanner: false,
    );
  }
}
