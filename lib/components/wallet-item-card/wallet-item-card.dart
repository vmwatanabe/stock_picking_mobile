import 'package:flutter/material.dart';
import 'package:stock_picking_mobile/classes/magic_payload.dart';
import 'package:stock_picking_mobile/classes/stock_list_item.dart';
import 'package:stock_picking_mobile/classes/wallet_item.dart';

class WalletItemCard extends StatefulWidget {
  const WalletItemCard({Key? key, required this.data, this.magic})
      : super(key: key);

  final WalletItem data;
  final PayloadData? magic;

  @override
  _WalletItemCardState createState() {
    return _WalletItemCardState();
  }
}

class _WalletItemCardState extends State<WalletItemCard> {
  StockListItem? magicPair;

  @override
  void initState() {
    super.initState();
    try {
      magicPair = widget.magic?.items
          .firstWhere((element) => element.papel == widget.data.name);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Row(
          children: [Text(widget.data.name), Text(magicPair?.empresa ?? '')],
        ),
        Row(
          children: [
            Text(widget.data.price.toString()),
            Text(widget.data.quantity.toString()),
            Text(widget.data.buyDate.toString()),
          ],
        )
      ],
    ));
  }
}
