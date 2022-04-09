enum StockTransactionType { buy, sell }

class StockTransaction {
  const StockTransaction(
      {this.id,
      required this.type,
      required this.ticker,
      required this.quantity,
      required this.price,
      required this.date});

  final int? id;
  final StockTransactionType type;
  final int quantity;
  final String ticker;
  final double price;
  final String date;

  StockTransaction.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        type = StockTransactionType.values[res["type"]],
        ticker = res["ticker"],
        quantity = res["quantity"],
        price = res["price"],
        date = res["date"];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.index,
      'price': price,
      'quantity': quantity,
      'ticker': ticker,
      'date': date,
    };
  }
}
