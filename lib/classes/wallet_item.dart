class WalletItem {
  const WalletItem(
      {this.id,
      required this.name,
      required this.quantity,
      required this.price,
      required this.buyDate});

  final int? id;
  final int quantity;
  final String name;
  final double price;
  final String buyDate;

  WalletItem.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"],
        quantity = res["quantity"],
        price = res["price"],
        buyDate = res["buyDate"];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'price': price,
      'quantity': quantity,
      'name': name,
      'buyDate': buyDate,
    };
  }
}
