import 'package:stock_picking_mobile/classes/stock_list_item.dart';
import 'package:stock_picking_mobile/classes/wallet_item.dart';

class WalletCardInfo extends WalletItem {
  const WalletCardInfo(
      {required this.stockListItem, id, name, quantity, price, date})
      : super(id: id, quantity: quantity, name: name, price: price, date: date);

  final StockListItem? stockListItem;

  String? get empresa {
    return stockListItem?.empresa;
  }

  double get initialTotal {
    return price * quantity;
  }

  double get currentTotal {
    return (stockListItem?.cotacao ?? 0) * quantity;
  }

  double get pnl {
    return currentTotal - initialTotal;
  }

  String? get sector {
    return stockListItem?.setor;
  }

  int? get magicRanking {
    return stockListItem?.magicRanking;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'price': price,
      'quantity': quantity,
      'name': name,
      'date': date,
      'empresa': empresa,
      'initialTotal': initialTotal,
      'currentTotal': currentTotal,
      'pnl': pnl,
    };
  }
}
