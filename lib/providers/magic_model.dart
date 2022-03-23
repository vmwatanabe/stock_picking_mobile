import 'package:flutter/material.dart';
import 'package:stock_picking_mobile/classes/magic_payload.dart';

class MagicModel extends ChangeNotifier {
  PayloadData? _data;

  PayloadData? get data => _data;

  void setData(PayloadData newData) {
    _data = newData;
    notifyListeners();
  }
}
