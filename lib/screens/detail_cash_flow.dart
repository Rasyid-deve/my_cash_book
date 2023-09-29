import 'package:flutter/material.dart';
import 'package:my_cash_book/screens/setting.dart';

class HalamanDetailCashFlow extends StatefulWidget {
  const HalamanDetailCashFlow({super.key});

  @override
  State<HalamanDetailCashFlow> createState() => _HalamanDetailCashFlowState();
}

class _HalamanDetailCashFlowState extends State<HalamanDetailCashFlow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Cash Flow'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HalamanSetting(),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}