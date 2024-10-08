import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:traqq/utils/helper.dart';

class ProductDatabase {
  static final ProductDatabase _instance = ProductDatabase._internal();

  factory ProductDatabase() => _instance;

  ProductDatabase._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'product_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        product_id INTEGER,
        title TEXT,
        thumbnail TEXT,
        price REAL,
        quantity INTEGER
      )
    ''');
  }

  // Create a product
  Future<int> insertProduct(Map<String, dynamic> product) async {
    AppHelper.myPrint("------------ Product -------------");
    AppHelper.myPrint(product);
    AppHelper.myPrint("-------------------------");
    final db = await database;
    return await db.insert('products', product);
  }

  // Delete a product by ID
  Future<int> deleteProduct(int id) async {
    final db = await database;
    return await db.delete('products', where: 'product_id = ?', whereArgs: [id]);
  }

  // Update quantity of a product by ID
  Future<int> updateQuantity(int id, int newQuantity) async {
    final db = await database;
    return await db.update(
      'products',
      {'quantity': newQuantity},
      where: 'product_id = ?',
      whereArgs: [id],
    );
  }

  // Get total price (sum of price * quantity)
  Future<double> getTotalPrice() async {
    final db = await database;
    var result = await db.rawQuery(
      'SELECT SUM(price * quantity) as total FROM products',
    );
    return result.first['total'] == null
        ? 0.0
        : result.first['total'] as double;
  }

  // Get all products
  Future<List<Map<String, dynamic>>> getAllProducts() async {
    final db = await database;
    return await db.query('products');
  }

  // Close the database
  Future close() async {
    final db = await database;
    db.close();
  }
}
