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
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      initialRoute: '/magic',
      debugShowCheckedModeBanner: false,
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
