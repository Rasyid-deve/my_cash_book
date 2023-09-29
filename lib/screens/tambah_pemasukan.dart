import 'package:flutter/material.dart';
import 'package:my_cash_book/screens/tambah_pengeluaran.dart';

class HalamanPemasukan extends StatefulWidget {
  const HalamanPemasukan({super.key});

  @override
  State<HalamanPemasukan> createState() => _HalamanPemasukanState();
}

class _HalamanPemasukanState extends State<HalamanPemasukan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Pemasukan'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HalamanPengeluaran(),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
