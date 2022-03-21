import 'package:flutter/material.dart';

class RootScaffold {
  static openDrawer(BuildContext context) {
    final ScaffoldState? scaffoldState =
        context.findRootAncestorStateOfType<ScaffoldState>();
    scaffoldState?.openDrawer();
  }
}

class RootDrawer {
  static DrawerControllerState? of(BuildContext context) {
    final DrawerControllerState? drawerControllerState =
        context.findRootAncestorStateOfType<DrawerControllerState>();
    return drawerControllerState;
  }
}
