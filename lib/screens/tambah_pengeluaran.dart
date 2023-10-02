import 'package:flutter/material.dart';
import 'package:my_cash_book/models/user.dart';
import '../db_helper/db_helper.dart';
import '../models/transaksi.dart';

class HalamanPengeluaran extends StatefulWidget {
  const HalamanPengeluaran({super.key, required this.user});

  final User user;

  @override
  State<HalamanPengeluaran> createState() => _HalamanPengeluaranState();
}

class _HalamanPengeluaranState extends State<HalamanPengeluaran> {
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
    final DateTime? pilih = await showDatePicker(
        context: context,
        initialDate: pilihTanggal,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));
    if (pilih != null && pilih != pilihTanggal)
      setState(() {
        pilihTanggal = pilih;
        tanggalController.text = "${pilihTanggal.toLocal()}".split(' ')[0];
      });
  }

  void _resetFields() {
    tanggalController.clear();
    nominalController.clear();
    deskripsiController.clear();
  }

  void _saveTransaction(user_id, amount, description, status, date) {
    Transactions transaction = Transactions(
        user_id: user_id,
        amount: amount,
        description: description,
        status: 1,
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
        title: const Text('Tambah Pengeluaran'),
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
                      backgroundColor: Colors.green),
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
