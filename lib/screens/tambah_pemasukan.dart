import 'package:flutter/material.dart';
import '../db_helper/db_helper.dart';
import '../models/transaksi.dart';
import '../models/user.dart';

class HalamanPemasukan extends StatefulWidget {
  const HalamanPemasukan({super.key, required this.user});

  final User user;

  @override
  State<HalamanPemasukan> createState() => _HalamanPemasukanState();
}

class _HalamanPemasukanState extends State<HalamanPemasukan> {
  late User user;
  late DateTime pilihTanggal;
  TextEditingController tanggalController = TextEditingController();
  TextEditingController nominalController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    pilihTanggal = DateTime.now();
    tanggalController.text = "${pilihTanggal.toLocal()}".split(' ')[0];
    user = widget.user;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: pilihTanggal,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));
    if (picked != null && picked != pilihTanggal)
      setState(() {
        pilihTanggal = picked;
        tanggalController.text = "${pilihTanggal.toLocal()}".split(' ')[0];
      });
  }

  void _resetFields() {
    tanggalController.text = "2023-01-01";
    nominalController.clear();
    deskripsiController.clear();
  }

  void _saveTransaction(user_id, amount, description, status, date) {
    Transactions transaction = Transactions(
        user_id: user_id,
        amount: amount,
        description: description,
        status: 0,
        date: date);
    DatabaseHelper.instance.insertTransaction(transaction);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pemasukan tersimpan!')),
    );
    _resetFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Pemasukan'),
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              readOnly: true,
              controller: tanggalController,
              onTap: () => _selectDate(context),
              decoration: const InputDecoration(
                labelText: 'Tanggal',
                suffixIcon: Icon(Icons.calendar_month),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: nominalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nominal',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: deskripsiController,
              decoration: const InputDecoration(
                labelText: 'Keterangan',
              ),
            ),
            const SizedBox(height: 32),
            Column(
              children: [
                ElevatedButton(
                  onPressed: _resetFields,
                  child: Text('Reset'),
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.redAccent),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => _saveTransaction(
                    user.id,
                    int.parse(nominalController.text),
                    deskripsiController.text,
                    0,
                    pilihTanggal,
                  ),
                  child: Text('Simpan'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.green,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Kembali'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
