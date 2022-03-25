import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_picking_mobile/classes/scaffold.dart';
import 'package:stock_picking_mobile/classes/wallet_item.dart';
import 'package:stock_picking_mobile/components/add_wallet/add_wallet.dart';
import 'package:stock_picking_mobile/components/wallet_item_card/wallet_item_card.dart';
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
              body: ListView.separated(
                  itemCount: _list.length,
                  padding: const EdgeInsets.all(16),
                  separatorBuilder: (BuildContext context, int index) =>
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10)),
                  itemBuilder: (context, index) {
                    return WalletItemCard(
                        key: Key(_list[index].id!.toString()),
                        data: _list[index],
                        magic: magic.data,
                        onDelete: retrieveWalletItems);
                  }),
              floatingActionButton: _getFloatingActionButton(),
            ));
  }
}
