import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:stock_picking_mobile/classes/wallet_item.dart';

class WalletDatabaseHandler {
  final String _tableName = 'wallet_items';
  final String _dbName = 'stock_picking2.db';

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, _dbName),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE $_tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL,price REAL NOT NULL, buyDate TEXT NOT NULL, quantity INT NOT NULL)",
        );
      },
      version: 2,
    );
  }

  Future<List<WalletItem>> retrieveWalletItems() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query(_tableName);

    return queryResult.map((e) => WalletItem.fromMap(e)).toList();
  }

  Future<List<int>> insertWalletItems(List<WalletItem> walletItems) async {
    List<int> result = [];
    final Database db = await initializeDB();

    for (var walletItem in walletItems) {
      int id = await db.insert(_tableName, walletItem.toMap());
      result.add(id);
    }
    return result;
  }

  Future<void> deleteWalletItem(int id) async {
    final db = await initializeDB();
    await db.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
