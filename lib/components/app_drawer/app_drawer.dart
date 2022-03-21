import 'package:flutter/material.dart';
import 'package:stock_picking_mobile/classes/scaffold.dart';

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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.auto_fix_high),
            title: const Text("Magic List"),
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
