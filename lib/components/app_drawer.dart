import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_picking_mobile/classes/scaffold.dart';
import 'package:provider/provider.dart';
import 'package:stock_picking_mobile/providers/magic_model.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key, required this.navigator}) : super(key: key);

  final GlobalKey<NavigatorState> navigator;

  void _navigateToMagicList(BuildContext context) {
    final state = RootDrawer.of(context);
    navigator.currentState?.pushReplacementNamed('/magic');
    state?.close();
  }

  void _navigateToWallet(BuildContext context) {
    final state = RootDrawer.of(context);
    navigator.currentState?.pushReplacementNamed('/wallet');
    state?.close();
  }

  Widget? _getMagicSubTitle(BuildContext context) {
    MagicModel magic = context.read<MagicModel>();

    DateTime? date = magic.data?.date;

    if (date != null) {
      return Text('Updated: ' + DateFormat("dd/MM/yyyy").format(date));
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.auto_fix_high),
            title: const Text("Magic List"),
            subtitle: _getMagicSubTitle(context),
            onTap: () => _navigateToMagicList(context),
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet),
            title: const Text("Wallet"),
            onTap: () => _navigateToWallet(context),
          )
        ],
      ),
    );
  }
}
