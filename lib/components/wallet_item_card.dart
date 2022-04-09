import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:stock_picking_mobile/classes/wallet_card_info.dart';
import 'package:stock_picking_mobile/components/description_item.dart';
import 'package:stock_picking_mobile/services/stock_transaction_db_handler.dart';
import 'package:stock_picking_mobile/utils/index.dart';

class WalletItemCard extends StatefulWidget {
  const WalletItemCard({Key? key, required this.data, required this.onDelete})
      : super(key: key);

  final WalletCardInfo data;
  final Function onDelete;

  @override
  _WalletItemCardState createState() {
    return _WalletItemCardState();
  }
}

class _WalletItemCardState extends State<WalletItemCard> {
  late WalletDatabaseHandler handler;

  @override
  void initState() {
    super.initState();
    handler = WalletDatabaseHandler();
    handler.initializeDB();
  }

  void handleDeletePress(BuildContext context) async {
    await handler.deleteStockTransaction(widget.data.id!);
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
                        Text(widget.data.name + ' #${widget.data.magicRanking}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text(widget.data.empresa ?? '')
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
                              child:
                                  getFormattedDate(widget.data.date) ?? "-")),
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
                        child: getFormattedPrice(widget.data.initialTotal),
                      )),
                      Expanded(
                          child: DescriptionItem(
                        label: "Today",
                        child: getFormattedPrice(widget.data.currentTotal),
                      )),
                      Expanded(
                          child: DescriptionItem(
                              label: "P/L",
                              child: getFormattedPrice(widget.data.pnl),
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: widget.data.pnl > 0
                                      ? Colors.green
                                      : Colors.red))),
                    ],
                  ),
                )
              ],
            )));
  }
}
