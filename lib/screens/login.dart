import 'package:flutter/material.dart';
import 'package:my_cash_book/screens/beranda.dart';
import '../db_helper/db_helper.dart';
import '../models/user.dart';

class HalamanLogin extends StatefulWidget {
  const HalamanLogin({super.key, required String title});

  @override
  State<HalamanLogin> createState() => _HalamanLoginState();
}

class _HalamanLoginState extends State<HalamanLogin> {
  TextEditingController cUser = TextEditingController();
  TextEditingController cPass = TextEditingController();
  final formKey = GlobalKey<FormState>();

  
  Future<bool> checkUser(String username) async {
    User? user = await DatabaseHelper.instance.queryUser(username);
    if (user != null) {
      return true; // Login berhasil
    } else {
      return false; // Gagal login
    }
  }

  Future<User?> login(String username, String password) async {
    User? user = await DatabaseHelper.instance.queryUser(username);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('BKN Apps'),
          backgroundColor: Colors.blueGrey,
        ),
        body: Form(
          key: formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/logo.png',
                    width: 280.0,
                    height: 210.0,
                  ),
                 Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: cUser,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Username"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Isi Username!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: cPass,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Password"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Isi Password!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      minimumSize: const Size(200, 50),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        login(cUser.text, cPass.text)
                            .then((userData) {
                          if (userData != null &&
                              userData.password == cPass.text) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Beranda(user: userData)),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Username atau Password Salah!'),
                              ),
                            );
                          }
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Masukkan inputan'),
                          ),
                        );
                      }
                    },
                    child: const Text('Login'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
