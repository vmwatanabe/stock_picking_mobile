import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_picking_mobile/classes/scaffold.dart';
import 'package:stock_picking_mobile/classes/wallet_item.dart';
import 'package:stock_picking_mobile/components/add_wallet/add_wallet.dart';
import 'package:stock_picking_mobile/components/wallet-item-card/wallet-item-card.dart';
import 'package:stock_picking_mobile/providers/magic_model.dart';
import 'package:stock_picking_mobile/services/wallet_db_handler.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  List<WalletItem> _list = [];
  late WalletDatabaseHandler handler;

  @override
  void initState() {
    super.initState();
    handler = WalletDatabaseHandler();
    handler.initializeDB().whenComplete(retrieveWalletItems);
  }

  void retrieveWalletItems() async {
    List<WalletItem> list = await handler.retrieveWalletItems();
    setState(() {
      _list = list;
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
    handler.insertWalletItems([item]);
    retrieveWalletItems();
  }

  FloatingActionButton? _getFloatingActionButton() {
    return FloatingActionButton(
      tooltip: 'Adicionar',
      child: const Icon(Icons.add),
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => AddWallet(
                  onSubmit: (WalletItem item) {
                    handleSubmit(item);
                    Navigator.pop(context);
                  },
                ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MagicModel>(
        builder: (context, magic, child) => Scaffold(
              appBar: AppBar(
                leading: _buildLeadingButton(context),
                title: const Text("Wallet"),
              ),
              body: ListView(
                  children: _list
                      .map((e) => WalletItemCard(
                            data: e,
                            magic: magic.data,
                          ))
                      .toList()),
              floatingActionButton: _getFloatingActionButton(),
            ));
  }
}
