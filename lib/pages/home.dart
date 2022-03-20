import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:stock_picking_mobile/classes/index.dart';
import 'dart:async';
import 'dart:convert';

import 'package:stock_picking_mobile/components/stock_list/stock_list.dart';
import 'package:stock_picking_mobile/pages/stock_compare.dart';

class PayloadData {
  const PayloadData({Key? key, required this.date, required this.items});

  final DateTime date;
  final List<StockListItem> items;
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "";

  Map selectedRows = {};
  PayloadData? pageData;

  Future<PayloadData> fetchStockListData(http.Client client) async {
    final response = await client.get(
        Uri.parse('https://hardcore-hugle-720c0f.netlify.app/latest.json'));

    if (response.statusCode == 200) {
      PayloadData data = parseData(response.body);

      setState(() {
        pageData = data;
      });

      return data;
    }

    throw Exception('Failed to load data');
  }

  PayloadData parseData(String responseBody) {
    final parsed = jsonDecode(responseBody);

    DateTime date = DateTime.parse(parsed["dtCreated"]);

    return PayloadData(
        date: date,
        items: parsed["items"]
            .map<StockListItem>((json) => StockListItem.fromJson(json))
            .toList());
  }

  Widget _buildLeadingButton() {
    if (_isSearching) {
      return const BackButton();
    }

    return IconButton(
      icon: const Icon(Icons.menu),
      onPressed: () {
        _key.currentState!.openDrawer();
      },
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: "Search Data...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (query) => updateSearchQuery(query),
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController.text.isEmpty) {
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

  void _navigateToStockComparePage() {
    if (pageData?.items != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                StockCompare(items: pageData!.items, selected: selectedRows)),
      );
    }
  }

  FloatingActionButton? _getFloatingActionButton() {
    if (selectedRows.isEmpty) {
      return null;
    }

    return FloatingActionButton(
      tooltip: 'Comparar',
      child: const Icon(Icons.compare_arrows),
      onPressed: () {
        _navigateToStockComparePage();
      },
    );
  }

  void _onSelectionChanged(Map value) {
    setState(() {
      selectedRows = value;
    });
  }

  Drawer getDrawer() {
    ListTile getMagicListTile() {
      DateTime? date = pageData?.date;

      String text = date == null
          ? 'Falha ao carregar'
          : 'Última atualização: ' + DateFormat('dd/MM/yyy').format(date);

      return ListTile(
        leading: const Icon(Icons.auto_fix_high),
        title: const Text("Magic List"),
        subtitle: Text(text),
      );
    }

    return Drawer(
      child: ListView(
        children: [getMagicListTile()],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        leading: _buildLeadingButton(),
        title: _isSearching
            ? _buildSearchField()
            : const Text("Magic Stock Picking"),
        actions: _buildActions(),
      ),
      drawer: getDrawer(),
      body: FutureBuilder<PayloadData>(
        future: fetchStockListData(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Failed to load data"),
            );
          } else if (snapshot.hasData) {
            return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: StockList(
                    items: snapshot.data!.items,
                    onSelectionChange: _onSelectionChanged,
                    search: searchQuery));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: _getFloatingActionButton(),
    );
  }
}
