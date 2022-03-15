import 'package:flutter/material.dart';
import 'package:stock_picking_mobile/classes/index.dart';

class CompareList extends StatefulWidget {
  const CompareList({Key? key, required this.items}) : super(key: key);

  final List<StockListItem> items;

  @override
  _CompareListState createState() => _CompareListState();
}

class _CompareListState extends State<CompareList> {
  Map selected = {};

  @override
  Widget build(BuildContext context) {
    return DataTable(
        columns: _createColumns(widget.items), rows: _createRows(widget.items));
  }

  List<DataRow> _createRows(List<StockListItem> data) {
    List<String> rows =
        stockListLabelsMap.keys.toList().map((e) => e.toString()).toList();

    return rows
        .map((item) => DataRow(
              cells: [
                DataCell(Text(stockListLabelsMap[item])),
                ...(data.map((e) {
                  return DataCell(Text(e.toMap()[item].toString()));
                }))
              ],
            ))
        .toList();
  }
}

List<DataColumn> _createColumns(List<StockListItem> items) {
  List<String> columns = ["", ...(items.map((e) => e.papel))];

  return columns.map((column) => DataColumn(label: Text(column))).toList();
}
