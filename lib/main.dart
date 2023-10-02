import 'package:flutter/material.dart';
import 'package:my_cash_book/screens/login.dart';
import 'db_helper/db_helper.dart';
import 'models/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Future<bool> checkUser(String username) async {
    User? user = await DatabaseHelper.instance.queryUser(username);
    if (user != null) {
      return true; // Login berhasil
    } else {
      return false; // Gagal login
    }
  }

  @override
  Widget build(BuildContext context) {
    checkUser('rasyed').then(
      (value) {
        if (!value) {
          User user = User(id: 0, username: 'rasyed', password: '12345');
          DatabaseHelper.instance.insertUser(user);
        }
      },
    );

    return MaterialApp(
      title: 'LSP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HalamanLogin(),
      debugShowCheckedModeBanner: false,
    );
  }
}
