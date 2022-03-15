import 'dart:ffi';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:stock_picking_mobile/components/stock_list.dart';

class StockListItem {
  final String papel;
  final String empresa;
  final String setor;
  final String subsetor;
  final int magicRanking;
  final int evByEbitRanking;
  final int roicRanking;
  final double cotacao;
  final double cotacaoToTop30;
  final double pByL;
  final double pByVp;
  final double psr;
  final double dividendYield;
  final double pByAtivo;
  final double pByCapitalGiro;
  final double pByEbit;
  final double pByAtivoCircLiq;
  final double evByEbit;
  final double evByEbitda;
  final double margemEbit;
  final double margemLiq;
  final double liqCorr;
  final double roic;
  final double roe;
  final double liqDoisMeses;
  final double patrimonioLiquido;
  final double dividaBrutaByPatrimonio;
  final double crescRec;
  final String ultCotacao;
  final double numeroAcoes;
  final double ebit;
  final bool smallcap;
  final int magicValue;

  const StockListItem({
    required this.papel,
    required this.empresa,
    required this.cotacao,
    required this.pByL,
    required this.pByVp,
    required this.psr,
    required this.dividendYield,
    required this.pByAtivo,
    required this.pByCapitalGiro,
    required this.pByEbit,
    required this.pByAtivoCircLiq,
    required this.evByEbit,
    required this.evByEbitda,
    required this.margemEbit,
    required this.margemLiq,
    required this.liqCorr,
    required this.roic,
    required this.roe,
    required this.liqDoisMeses,
    required this.patrimonioLiquido,
    required this.dividaBrutaByPatrimonio,
    required this.crescRec,
    required this.subsetor,
    required this.setor,
    required this.ultCotacao,
    required this.numeroAcoes,
    required this.ebit,
    required this.smallcap,
    required this.evByEbitRanking,
    required this.roicRanking,
    required this.magicValue,
    required this.magicRanking,
    required this.cotacaoToTop30,
  });

  factory StockListItem.fromJson(Map<String, dynamic> json) {
    return StockListItem(
      papel: json['papel'],
      empresa: json['empresa'],
      cotacao: json['cotacao'],
      pByL: json['pByL'],
      pByVp: json['pByVp'],
      psr: json['psr'],
      dividendYield: json['dividendYield'],
      pByAtivo: json['pByAtivo'],
      pByCapitalGiro: json['pByCapitalGiro'],
      pByEbit: json['pByEbit'],
      pByAtivoCircLiq: json['pByAtivoCircLiq'],
      evByEbit: json['evByEbit'],
      evByEbitda: json['evByEbitda'],
      margemEbit: json['margemEbit'],
      margemLiq: json['margemLiq'],
      liqCorr: json['liqCorr'],
      roic: json['roic'],
      roe: json['roe'],
      liqDoisMeses: json['liqDoisMeses'],
      patrimonioLiquido: json['patrimonioLiquido'],
      dividaBrutaByPatrimonio: json['dividaBrutaByPatrimonio'],
      crescRec: json['crescRec'],
      subsetor: json['subsetor'],
      setor: json['setor'],
      ultCotacao: json['ultCotacao'],
      numeroAcoes: json['numeroAcoes'],
      ebit: json['ebit'],
      smallcap: json['smallcap'],
      evByEbitRanking: json['evByEbitRanking'],
      roicRanking: json['roicRanking'],
      magicValue: json['magicValue'],
      magicRanking: json['magicRanking'],
      cotacaoToTop30: json['cotacaoToTop30'],
    );
  }
}

Future<List<StockListItem>> fetchStockListData(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://hardcore-hugle-720c0f.netlify.app/latest.json'));

  if (response.statusCode == 200) {
    return parseData(response.body);
  }

  throw Exception('Failed to load data');
}

List<StockListItem> parseData(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed
      .map<StockListItem>((json) => StockListItem.fromJson(json))
      .toList();
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "";

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: "Search Data...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (query) => updateSearchQuery(query),
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)
        ?.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _isSearching ? const BackButton() : Container(),
        title: _isSearching
            ? _buildSearchField()
            : const Text("Magic Stock Picking"),
        actions: _buildActions(),
      ),
      body: FutureBuilder<List<StockListItem>>(
        future: fetchStockListData(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Failed to load data"),
            );
          } else if (snapshot.hasData) {
            return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child:
                        StockList(items: snapshot.data!, search: searchQuery)));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: const FloatingActionButton(
        tooltip: 'Add',
        child: Icon(Icons.add),
        onPressed: null,
      ),
    );
  }
}
