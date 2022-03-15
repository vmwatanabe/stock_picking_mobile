import 'package:flutter/material.dart';
import 'package:stock_picking_mobile/classes/index.dart';
import 'package:stock_picking_mobile/utils/index.dart';

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

  @override
  Widget build(BuildContext context) {
    return DataTable(
        columns: _createColumns(),
        rows: _createRows(widget.items, widget.search));
  }

  List<DataRow> _createRows(List<StockListItem> data, String search) {
    return data
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
                DataCell(Text(item.pByVp.toString())),
                DataCell(Text(item.psr.toString())),
                DataCell(Text(item.dividendYield.toString())),
                DataCell(Text(item.pByAtivo.toString())),
                DataCell(Text(item.pByCapitalGiro.toString())),
                DataCell(Text(item.pByEbit.toString())),
                DataCell(Text(item.pByAtivoCircLiq.toString())),
                DataCell(Text(item.evByEbit.toString())),
                DataCell(Text(item.evByEbitda.toString())),
                DataCell(Text(item.margemEbit.toString())),
                DataCell(Text(item.margemLiq.toString())),
                DataCell(Text(item.liqCorr.toString())),
                DataCell(Text(item.roic.toString())),
                DataCell(Text(item.roe.toString())),
                DataCell(Text(item.liqDoisMeses.toString())),
                DataCell(Text(item.patrimonioLiquido.toString())),
                DataCell(Text(item.dividaBrutaByPatrimonio.toString())),
                DataCell(Text(item.crescRec.toString())),
                DataCell(Text(item.smallcap.toString())),
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
}

List<DataColumn> _createColumns() {
  const List<String> columns = [
    "Ranking",
    "Papel",
    "Nome Empresa",
    "Setor",
    "Subsetor",
    "EV/EBIT Ranking",
    "ROIC Ranking",
    "Cotação",
    "Cotação para top 30",
    "P/L",
    "P/VP",
    "PSR",
    "Div.Yield",
    "P/Ativo",
    "P/Cap.Giro",
    "P/EBIT",
    "P/Ativ Circ.Liq",
    "EV/EBIT",
    "EV/EBITDA",
    "Mrg Ebit",
    "Mrg. Líq.",
    "Liq. Corr.",
    "ROIC",
    "ROE",
    "Liq.2meses",
    "Patrim. Líq",
    "Dív.Brut/ Patrim.",
    "Cresc. Rec.5a",
    "Smallcap",
  ];

  return columns.map((column) => DataColumn(label: Text(column))).toList();
}
