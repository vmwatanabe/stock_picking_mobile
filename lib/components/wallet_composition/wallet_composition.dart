import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:stock_picking_mobile/classes/wallet_card_info.dart';

class WalletComposition extends StatefulWidget {
  const WalletComposition({Key? key, required this.list}) : super(key: key);

  final List<WalletCardInfo> list;

  @override
  _WalletCompositionState createState() => _WalletCompositionState();
}

class _WalletCompositionState extends State<WalletComposition> {
  Widget _buildChart() {
    Map<String, double> sectorCount = {};

    for (WalletCardInfo item in widget.list) {
      sectorCount[item.sector!] = (sectorCount[item.sector] ?? 0) + 1;
    }

    if (sectorCount.isEmpty) {
      return Container();
    }

    return PieChart(
        dataMap: sectorCount,
        animationDuration: const Duration(milliseconds: 800),
        chartRadius: MediaQuery.of(context).size.width / 3.2 > 300
            ? 300
            : MediaQuery.of(context).size.width / 1.2,
        initialAngleInDegree: 0,
        legendOptions:
            const LegendOptions(legendPosition: LegendPosition.bottom),
        colorList: const [
          Colors.red,
          Colors.teal,
          Colors.purple,
          Colors.lightBlue,
          Colors.deepPurple,
          Colors.cyan,
          Colors.brown,
          Colors.indigo,
          Colors.deepOrange,
          Colors.lightGreen,
          Colors.blue,
          Colors.pink,
          Colors.green,
          Colors.lime,
          Colors.yellow,
          Colors.amber,
          Colors.orange,
          Colors.grey,
          Colors.blueGrey
        ],
        chartValuesOptions:
            const ChartValuesOptions(showChartValuesInPercentage: true));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Wallet composition",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
          child: _buildChart(),
        )
      ],
    );
  }
}
