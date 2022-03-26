import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_picking_mobile/classes/scaffold.dart';
import 'package:stock_picking_mobile/classes/stock_list_item.dart';
import 'package:stock_picking_mobile/classes/wallet_card_info.dart';
import 'package:stock_picking_mobile/classes/wallet_item.dart';
import 'package:stock_picking_mobile/components/add_wallet/add_wallet.dart';
import 'package:stock_picking_mobile/components/wallet_composition/wallet_composition.dart';
import 'package:stock_picking_mobile/components/wallet_item_card/wallet_item_card.dart';
import 'package:stock_picking_mobile/providers/magic_model.dart';
import 'package:stock_picking_mobile/services/wallet_db_handler.dart';

enum OrderedBy {
  ticker,
  profitabilityAsc,
  profitabilityDesc,
}

extension OrderedByExtension on OrderedBy {
  String get displayTitle {
    switch (this) {
      case OrderedBy.ticker:
        return 'Ticker';
      case OrderedBy.profitabilityAsc:
        return 'Profitability (Asc)';
      case OrderedBy.profitabilityDesc:
        return 'Profitability (Desc)';
    }
  }

  String get propToCompare {
    switch (this) {
      case OrderedBy.ticker:
        return 'name';
      case OrderedBy.profitabilityAsc:
        return 'pnl';
      case OrderedBy.profitabilityDesc:
        return 'pnl';
    }
  }

  bool get sortReversed {
    switch (this) {
      case OrderedBy.profitabilityDesc:
        return true;
      default:
        return false;
    }
  }
}

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  List<WalletCardInfo> _list = [];
  late WalletDatabaseHandler handler;
  OrderedBy _orderedBy = OrderedBy.ticker;

  @override
  void initState() {
    super.initState();
    handler = WalletDatabaseHandler();
    handler.initializeDB().whenComplete(retrieveWalletItems);
  }

  List<WalletCardInfo> sortList(List<WalletCardInfo> data) {
    data.sort((a, b) {
      var first = _orderedBy.sortReversed ? b : a;
      var second = _orderedBy.sortReversed ? a : b;

      return first
          .toMap()[_orderedBy.propToCompare]
          .compareTo(second.toMap()[_orderedBy.propToCompare]);
    });

    return data;
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
      _list = sortList(newList);
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

  Widget _buildFilter() {
    return Expanded(
        child: DropdownButtonFormField<OrderedBy>(
            decoration: const InputDecoration(
              label: Text(
                "Order by",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              enabledBorder: InputBorder.none,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
            iconSize: 0.0,
            value: _orderedBy,
            onChanged: (OrderedBy? newValue) {
              if (newValue != null) {
                setState(() {
                  _orderedBy = newValue;
                  _list = sortList(_list);
                });
              }
            },
            items: OrderedBy.values.map((OrderedBy classType) {
              return DropdownMenuItem<OrderedBy>(
                  value: classType, child: Text(classType.displayTitle));
            }).toList()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _buildLeadingButton(context),
        title: const Text("Wallet"),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              WalletComposition(list: _list),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [_buildFilter()],
                ),
              ),
              ListView.separated(
                  itemCount: _list.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
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
            ],
          )),
      floatingActionButton: _getFloatingActionButton(),
    );
  }
}
