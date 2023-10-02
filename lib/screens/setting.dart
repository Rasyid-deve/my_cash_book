import 'package:flutter/material.dart';
import 'package:my_cash_book/models/user.dart';
import '../db_helper/db_helper.dart';

class HalamanSetting extends StatefulWidget {
  const HalamanSetting({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<HalamanSetting> createState() => _HalamanSettingState();
}

class _HalamanSettingState extends State<HalamanSetting> {
  late User user;
  late TextEditingController _cPassController;
  late TextEditingController _nPassController;

  @override
  void initState() {
    super.initState();
    user = widget.user;
    _cPassController = TextEditingController();
    _nPassController = TextEditingController();
  }

  Future<bool> checkUser(String username) async {
    User? user = await DatabaseHelper.instance.queryUser(username);
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<User?> login(String username, String password) async {
    User? user = await DatabaseHelper.instance.queryUser(username);
    return user;
  }

  void _resetFields() {
    _cPassController.clear();
    _nPassController.clear();
  }

  void _savePassword(cPass, nPass) {
    if (cPass == user.password) {
      DatabaseHelper.instance.queryUpdatePassword(user.id, nPass);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password lama salah!'),
        ),
      );
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Password berhasil diubah!'),
      ),
    );
    _resetFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Ganti Password',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _cPassController,
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Password Lama"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Isikan password lama anda!';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nPassController,
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Password Baru"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Isikan password baru anda!';
                }
                return null;
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Aksi ketika tombol simpan ditekan
                String currentPassword = _cPassController.text;
                String newPassword = _nPassController.text;

                _savePassword(currentPassword, newPassword);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Simpan'),
            ),
            ElevatedButton(
              onPressed: () {
                // Aksi ketika tombol kembali ditekan
                Navigator.pop(context);
              },
              child: const Text('Kembali'),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/foto.jpg',
                      width: 150,
                      height: 150,
                    )
                  ],
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About this app',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text('Aplikasi ini dibuat oleh :'),
                    Text('Nama : Rasyed Renaldi'),
                    Text('NIM : 1941720177'),
                    Text('Tanggal : 30 September 2023'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
