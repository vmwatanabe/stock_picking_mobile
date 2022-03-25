import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_picking_mobile/classes/scaffold.dart';
import 'package:stock_picking_mobile/classes/stock_list_item.dart';
import 'package:stock_picking_mobile/classes/wallet_card_info.dart';
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
  List<WalletCardInfo> _list = [];
  late WalletDatabaseHandler handler;

  @override
  void initState() {
    super.initState();
    handler = WalletDatabaseHandler();
    handler.initializeDB().whenComplete(retrieveWalletItems);
  }

  void retrieveWalletItems() async {
    List<WalletItem> list = await handler.retrieveWalletItems();
    MagicModel magic = context.read<MagicModel>();

    List<StockListItem>? stockListItems = magic.data?.items;

    List<WalletCardInfo> newList = list.map((elem) {
      StockListItem? magicPair =
          stockListItems?.firstWhere((element) => element.papel == elem.name);

      return WalletCardInfo(
          stockListItem: magicPair,
          buyDate: elem.buyDate,
          id: elem.id,
          name: elem.name,
          price: elem.price,
          quantity: elem.quantity);
    }).toList();

    setState(() {
      _list = newList;
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
                        onDelete: retrieveWalletItems);
                  }),
              floatingActionButton: _getFloatingActionButton(),
            ));
  }
}
