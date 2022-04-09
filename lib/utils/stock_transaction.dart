import 'package:stock_picking_mobile/classes/stock_transaction.dart';
import 'package:stock_picking_mobile/classes/wallet_item.dart';

List<WalletItem> toWalletItemList(List<StockTransaction> list) {
  Map<String, List<StockTransaction>> tickerMap = {};

  void iterateList(StockTransaction element) {
    if (tickerMap[element.ticker] == null) {
      tickerMap[element.ticker] = [];
    }

    tickerMap[element.ticker]?.add(element);
  }

  list.forEach(iterateList);

  List<WalletItem> response = [];

  void iterateMap(element) {
    var valuesList = element.value;

    var quantity = 0;
    var price = 0.0;
    String lastBuyDate = "";

    void iterateValues(StockTransaction valueListElement) {
      if (valueListElement.type == StockTransactionType.buy) {
        price = ((valueListElement.price * valueListElement.quantity) +
                (price * quantity)) /
            (valueListElement.quantity + quantity);
        quantity += valueListElement.quantity;
        lastBuyDate = valueListElement.date;
      } else if (valueListElement.type == StockTransactionType.sell) {
        quantity -= valueListElement.quantity;
      }
    }

    valuesList.forEach(iterateValues);

    response.add(WalletItem(
        date: lastBuyDate,
        name: element.key,
        price: price,
        quantity: quantity));
  }

  tickerMap.entries.forEach(iterateMap);

  return response;
}
