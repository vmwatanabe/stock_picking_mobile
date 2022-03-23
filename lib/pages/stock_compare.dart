import 'package:flutter/material.dart';
import 'package:stock_picking_mobile/classes/stock_list_item.dart';
import 'package:stock_picking_mobile/components/compare_list/compare_list.dart';

class StockCompare extends StatelessWidget {
  const StockCompare({Key? key, required this.items, required this.selected})
      : super(key: key);

  final List<StockListItem> items;
  final Map selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Second Route'),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: CompareList(
                  items: items
                      .where((element) => selected.containsKey(element.papel))
                      .toList(),
                ))));
  }
}
