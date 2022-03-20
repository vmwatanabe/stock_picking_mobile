import 'package:flutter/material.dart';
import 'package:stock_picking_mobile/classes/index.dart';
import 'package:stock_picking_mobile/utils/index.dart';
import 'package:visibility_detector/visibility_detector.dart';

class StockList extends StatefulWidget {
  const StockList(
      {Key? key,
      required this.items,
      required this.onSelectionChange,
      this.search = ""})
      : super(key: key);

  final List<StockListItem> items;
  final String search;
  final Function(Map value) onSelectionChange;

  @override
  _StockListState createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  Map selected = {};
  final pageSize = 30;
  int pages = 1;
  bool canLoadMore = false;

  void _showMoreItems(visibilityInfo) {
    if (visibilityInfo.visibleFraction == 1 && !canLoadMore) {
      setState(() {
        pages = pages + 1;
        canLoadMore = true;
      });
    } else {
      setState(() {
        canLoadMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                columns: _createColumns(),
                rows: _createRows(widget.items, widget.search))),
        VisibilityDetector(
            key: const Key('loading'),
            onVisibilityChanged: _showMoreItems,
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: const Center(
                  child: CircularProgressIndicator(),
                ))),
      ],
    );
  }

  List<DataRow> _createRows(List<StockListItem> data, String search) {
    return data
        .sublist(0, pages * pageSize)
        .where((elem) =>
            stringMatches(elem.papel, search) ||
            stringMatches(elem.empresa, search))
        .map((item) => DataRow(
              cells: [
                DataCell(Text(item.magicRanking.toString())),
                DataCell(Text(item.papel.toString())),
                DataCell(Text(item.empresa.toString())),
                DataCell(Text(item.setor.toString())),
                DataCell(Text(item.subsetor.toString())),
                DataCell(Text(item.evByEbitRanking.toString())),
                DataCell(Text(item.roicRanking.toString())),
                DataCell(Text(item.cotacao.toString())),
                DataCell(Text(item.cotacaoToTop30.toString())),
                DataCell(Text(item.pByL.toString())),
                DataCell(Text(item.dividendYield.toString())),
                DataCell(Text(item.roic.toString())),
                DataCell(Text(item.roe.toString())),
              ],
              selected: selected.containsKey(item.papel)
                  ? selected[item.papel]
                  : false,
              onSelectChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    selected[item.papel] = value!;
                  } else {
                    selected.remove(item.papel);
                  }
                });
                widget.onSelectionChange(selected);
              },
            ))
        .toList();
  }

  List<DataColumn> _createColumns() {
    const List<String> columns = [
      "#",
      "Papel",
      "Nome Empresa",
      "Setor",
      "Subsetor",
      "EV/EBIT Ranking",
      "ROIC Ranking",
      "Cotação",
      "Cotação para top 30",
      "P/L",
      "Div.Yield",
      "ROIC",
      "ROE",
    ];

    return columns.map((column) => DataColumn(label: Text(column))).toList();
  }
}
