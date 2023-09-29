import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
// import 'package:my_cash_book/component/component.dart';
// import 'package:my_cash_book/screens/login.dart';
import 'detail_cash_flow.dart';
import 'setting.dart';
import 'tambah_pemasukan.dart';
import 'tambah_pengeluaran.dart';

class Beranda extends StatefulWidget {
  const Beranda({Key? key}) : super(key: key);

  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BKN Apps'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: AspectRatio(
          aspectRatio: 1,
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: const [
                    FlSpot(0, 3),
                    FlSpot(2.6, 2),
                    FlSpot(4.9, 5),
                    FlSpot(6.8, 2.5),
                    FlSpot(8, 4),
                    FlSpot(9.5, 3),
                    FlSpot(11, 4),
                  ],
                  isCurved: true,
                  dotData: const FlDotData(show: true),
                  color: Colors.blue,
                  barWidth: 5,
                  belowBarData: BarAreaData(
                    show: true,
                    color: Colors.green.withOpacity(0.7),
                  ),
                ),
              ],
              minX: 0,
              maxX: 11,
              minY: 2,
              maxY: 5,
              titlesData: const FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  axisNameWidget: Text('Tanggal'),
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    interval: 1,
                  ),
                ),
                leftTitles: AxisTitles(
                  axisNameWidget: Text('Nominal'),
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HalamanPemasukan(),
                ),
              );
            },
            icon: Icon(Icons.attach_money),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HalamanPengeluaran(),
                ),
              );
            },
            icon: Icon(Icons.money_off),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HalamanDetailCashFlow(),
                ),
              );
            },
            icon: Icon(Icons.show_chart),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HalamanSetting(),
                ),
              );
            },
            icon: Icon(Icons.settings),
          )
        ],
      ),
    );
  }
}
