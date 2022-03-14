import 'package:flutter/material.dart';

class StockList extends StatelessWidget {
  const StockList({Key? key}) : super(key: key);

  static List<String> columns = [
    "Papel",
    "Nome Empresa",
    "Setor",
    "Subsetor",
    "Magic Ranking",
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

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Text("Papel"),
        ),
        DataColumn(
          label: Text("Nome Empresa"),
        ),
        DataColumn(
          label: Text("Setor"),
        ),
        DataColumn(
          label: Text("Subsetor"),
        ),
        DataColumn(
          label: Text("Magic Ranking"),
        ),
        DataColumn(
          label: Text("EV/EBIT Ranking"),
        ),
        DataColumn(
          label: Text("ROIC Ranking"),
        ),
        DataColumn(
          label: Text("Cotação"),
        ),
        DataColumn(
          label: Text("Cotação para top 30"),
        ),
        DataColumn(
          label: Text("P/L"),
        ),
        DataColumn(
          label: Text("P/VP"),
        ),
        DataColumn(
          label: Text("PSR"),
        ),
        DataColumn(
          label: Text("Div.Yield"),
        ),
        DataColumn(
          label: Text("P/Ativo"),
        ),
        DataColumn(
          label: Text("P/Cap.Giro"),
        ),
        DataColumn(
          label: Text("P/EBIT"),
        ),
        DataColumn(
          label: Text("P/Ativ Circ.Liq"),
        ),
        DataColumn(
          label: Text("EV/EBIT"),
        ),
        DataColumn(
          label: Text("EV/EBITDA"),
        ),
        DataColumn(
          label: Text("Mrg Ebit"),
        ),
        DataColumn(
          label: Text("Mrg. Líq."),
        ),
        DataColumn(
          label: Text("Liq. Corr."),
        ),
        DataColumn(
          label: Text("ROIC"),
        ),
        DataColumn(
          label: Text("ROE"),
        ),
        DataColumn(
          label: Text("Liq.2meses"),
        ),
        DataColumn(
          label: Text("Patrim. Líq"),
        ),
        DataColumn(
          label: Text("Dív.Brut/ Patrim."),
        ),
        DataColumn(
          label: Text("Cresc. Rec.5a"),
        ),
        DataColumn(
          label: Text("Smallcap"),
        ),
      ],
      rows: const <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Sarah')),
            DataCell(Text('19')),
            DataCell(Text('Student')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Janine')),
            DataCell(Text('43')),
            DataCell(Text('Professor')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('William')),
            DataCell(Text('27')),
            DataCell(Text('Associate Professor')),
          ],
        ),
      ],
    );
  }
}

// List<DataRow> _createRows() {
//     return _books
//         .map((book) => DataRow(cells: [
//               DataCell(Text('#' + book['id'].toString())),
//               DataCell(Text(book['title'])),
//               DataCell(Text(book['author']))
//             ]))
//         .toList();
//   }
// }