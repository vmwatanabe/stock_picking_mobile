import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_picking_mobile/components/app_drawer/app_drawer.dart';
import 'package:stock_picking_mobile/pages/home.dart';
import 'package:stock_picking_mobile/pages/wallet.dart';
import 'package:stock_picking_mobile/providers/magic_model.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => MagicModel(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Picker',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepOrange,
      ),
      initialRoute: '/magic',
      routes: {
        '/magic': (context) => const Home(),
        '/wallet': (context) => const Wallet(),
      },
      builder: (context, child) {
        return Scaffold(
          drawer: AppDrawer(
            navigator: (child?.key as GlobalKey<NavigatorState>),
          ),
          body: child,
        );
      },
    );
  }
}
