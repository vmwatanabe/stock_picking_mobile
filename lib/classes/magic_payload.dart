import 'package:flutter/material.dart';
import 'package:stock_picking_mobile/classes/stock_list_item.dart';

class PayloadData {
  const PayloadData({Key? key, required this.date, required this.items});

  final DateTime date;
  final List<StockListItem> items;
}
