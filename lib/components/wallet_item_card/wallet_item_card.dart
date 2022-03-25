import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:stock_picking_mobile/classes/magic_payload.dart';
import 'package:stock_picking_mobile/classes/stock_list_item.dart';
import 'package:stock_picking_mobile/classes/wallet_item.dart';
import 'package:stock_picking_mobile/services/wallet_db_handler.dart';
import 'package:stock_picking_mobile/utils/index.dart';

class WalletItemCard extends StatefulWidget {
  const WalletItemCard(
      {Key? key, required this.data, this.magic, required this.onDelete})
      : super(key: key);

  final WalletItem data;
  final PayloadData? magic;
  final Function onDelete;

  @override
  _WalletItemCardState createState() {
    return _WalletItemCardState();
  }
}

class _WalletItemCardState extends State<WalletItemCard> {
  StockListItem? magicPair;
  late WalletDatabaseHandler handler;
  double initialTotal = 0;
  double currentTotal = 0;
  double pnl = 0;

  @override
  void initState() {
    super.initState();
    handler = WalletDatabaseHandler();
    handler.initializeDB();

    try {
      magicPair = widget.magic?.items
          .firstWhere((element) => element.papel == widget.data.name);

      initialTotal = widget.data.price * widget.data.quantity;
      currentTotal = widget.data.quantity * (magicPair?.cotacao ?? 0);
      pnl = currentTotal - initialTotal;
    } catch (e) {}
  }

  void handleDeletePress(BuildContext context) async {
    await handler.deleteWalletItem(widget.data.id!);
    widget.onDelete();
  }

  void handleEditPress(BuildContext context) {
    print(1);
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: handleDeletePress,
              foregroundColor: Colors.red,
              icon: Icons.archive,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: handleEditPress,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black12,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.data.name,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text(magicPair?.empresa ?? '')
                      ],
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: DescriptionItem(
                        label: "Price",
                        child: getFormattedPrice(widget.data.price),
                      )),
                      Expanded(
                          child: DescriptionItem(
                              label: "Quant.",
                              child: widget.data.quantity.toString())),
                      Expanded(
                          child: DescriptionItem(
                              label: "Buy Date.",
                              child: getFormattedDate(widget.data.buyDate) ??
                                  "-")),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: DescriptionItem(
                        label: "Invested",
                        child: getFormattedPrice(initialTotal),
                      )),
                      Expanded(
                          child: DescriptionItem(
                        label: "Today",
                        child: getFormattedPrice(currentTotal),
                      )),
                      Expanded(
                          child: DescriptionItem(
                              label: "P/L",
                              child: getFormattedPrice(pnl),
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: pnl > 0 ? Colors.green : Colors.red))),
                    ],
                  ),
                )
              ],
            )));
  }
}

class DescriptionItem extends StatelessWidget {
  const DescriptionItem(
      {Key? key, required this.label, required this.child, this.style})
      : super(key: key);

  final String label;
  final String child;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
        ),
        Text(child,
            style: style ??
                const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
      ],
    );
  }
}