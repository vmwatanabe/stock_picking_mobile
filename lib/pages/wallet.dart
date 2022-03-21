import 'package:flutter/material.dart';
import 'package:stock_picking_mobile/classes/scaffold.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  bool _isAdding = false;

  Widget _buildLeadingButton(BuildContext context) {
    if (_isAdding) {
      return const BackButton();
    }

    return IconButton(
      icon: const Icon(Icons.menu),
      onPressed: () {
        RootScaffold.openDrawer(context);
      },
    );
  }

  FloatingActionButton? _getFloatingActionButton() {
    return FloatingActionButton(
      tooltip: 'Adicionar',
      child: const Icon(Icons.add),
      onPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _buildLeadingButton(context),
        title: const Text("Wallet"),
      ),
      body: Container(),
      floatingActionButton: _getFloatingActionButton(),
    );
  }
}
