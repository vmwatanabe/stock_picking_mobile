import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:stock_picking_mobile/classes/stock_transaction.dart';

class WalletDatabaseHandler {
  final String _tableName = 'stock_transactions';
  final String _dbName = 'stock_picking4.db';

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, _dbName),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE $_tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, type INTEGER NOT_NULL, ticker TEXT NOT NULL, price REAL NOT NULL, date TEXT NOT NULL, quantity INT NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<List<StockTransaction>> retrieveStockTransactions() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(_tableName);

    return queryResult.map((e) => StockTransaction.fromMap(e)).toList();
  }

  Future<List<int>> insertWalletItems(
      List<StockTransaction> stockTransactions) async {
    List<int> result = [];
    final Database db = await initializeDB();

    for (var stockTransaction in stockTransactions) {
      int id = await db.insert(_tableName, stockTransaction.toMap());
      result.add(id);
    }
    return result;
  }

  Future<void> deleteStockTransaction(int id) async {
    final db = await initializeDB();
    await db.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
