import 'package:flutter/material.dart';
import 'package:stock_picking_mobile/classes/scaffold.dart';
import 'package:stock_picking_mobile/classes/wallet_item.dart';
import 'package:stock_picking_mobile/components/add_wallet/add_wallet.dart';
import 'package:stock_picking_mobile/components/wallet-item-card/wallet-item-card.dart';
import 'package:stock_picking_mobile/services/wallet_db_handler.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  bool _isAdding = false;

  List<WalletItem> _list = [];
  late WalletDatabaseHandler handler;

  @override
  void initState() {
    super.initState();
    handler = WalletDatabaseHandler();
    handler.initializeDB().whenComplete(() async {
      List<WalletItem> list = await handler.retrieveWalletItems();
      setState(() {
        _list = list;
      });
    });
  }

  Widget _buildLeadingButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu),
      onPressed: () {
        RootScaffold.openDrawer(context);
      },
    );
  }

  void handleSubmit(WalletItem item) {
    print(item);
    handler.insertWalletItems([item]);
  }

  FloatingActionButton? _getFloatingActionButton() {
    return FloatingActionButton(
      tooltip: 'Adicionar',
      child: const Icon(Icons.add),
      onPressed: () {
        setState(() {
          _isAdding = true;
        });

        showDialog(
            context: context,
            builder: (BuildContext context) => AddWallet(
                  onSubmit: handleSubmit,
                ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _buildLeadingButton(context),
        title: const Text("Wallet"),
      ),
      body: ListView(
          children: _list
              .map((e) => WalletItemCard(
                    data: e,
                  ))
              .toList()),
      floatingActionButton: _getFloatingActionButton(),
    );
  }
}
