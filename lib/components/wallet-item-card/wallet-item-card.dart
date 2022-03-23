import 'package:flutter/material.dart';
import 'package:stock_picking_mobile/classes/wallet_item.dart';

class WalletItemCard extends StatelessWidget {
  const WalletItemCard({Key? key, required this.data}) : super(key: key);

  final WalletItem data;

  @override
  Widget build(BuildContext context) {
    return Container(child: Text(data.name));
  }
}
