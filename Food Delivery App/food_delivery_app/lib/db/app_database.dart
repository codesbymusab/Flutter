import 'package:food_delivery_app/models/cart_items_model.dart';
import 'package:food_delivery_app/models/categories.dart';
import 'package:food_delivery_app/models/item_model.dart';
import 'package:food_delivery_app/models/order_items.dart';
import 'package:food_delivery_app/models/order_model.dart';
import 'package:food_delivery_app/models/price_list_model.dart';
import 'package:food_delivery_app/models/user_favourites.dart';
import 'package:food_delivery_app/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static AppDatabase instance = AppDatabase._init();

  AppDatabase._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _init('food_app_v2_0_1.db');
    return _database!;
  }

  Future<Database> _init(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = ('$dbPath$filePath');
    final db = await openDatabase(
      path,
      version: 4,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );

    return db;
  }

  Future<void> _upgradeDB(Database db, int version, int newVersion) async {}

  Future<void> _createDB(Database db, int version) async {
    final idType = 'TEXT PRIMARY KEY';
    final textType = 'TEXT NOT NULL';
    final intType = 'INTEGER NOT NULL';
    final doubleType = 'REAL NOT NULL';

    db.execute('''CREATE TABLE $tableUser (
      ${UserFields.id} $idType,
      ${UserFields.username} $textType,
      ${UserFields.email} $textType,
      ${UserFields.password} $textType,
      ${UserFields.joinedAt} $textType

      )''');

    db.execute('''CREATE TABLE $tableCategories (
      ${CategoryFields.id} $idType,
      ${CategoryFields.name} TEXT UNIQUE
      

      )''');

    db.execute('''

    CREATE TABLE $tableItems (
    ${ItemFields.id} $idType,
    ${ItemFields.name} $textType,
    ${ItemFields.category} $textType,
    ${ItemFields.description} $textType,
    ${ItemFields.imageUrl} $textType,
    FOREIGN KEY (${ItemFields.category}) REFERENCES $tableCategories (${CategoryFields.name}) ON DELETE CASCADE
  
    )


    ''');

    db.execute('''CREATE TABLE $tableCart (
      ${CartItemsFields.id} $idType,
      ${CartItemsFields.userId} $textType,
      ${CartItemsFields.itemID} $textType,
      ${CartItemsFields.quantity} $intType,
      ${CartItemsFields.size} $textType,

      FOREIGN KEY (${CartItemsFields.userId}) REFERENCES $tableUser (${UserFields.id}) ON DELETE CASCADE,
      FOREIGN KEY (${CartItemsFields.itemID}) REFERENCES $tableItems (${ItemFields.id}) ON DELETE CASCADE
      )''');

    db.execute('''CREATE TABLE $tableFavourites (
      ${FavouritesFields.id} $idType,
      ${FavouritesFields.userId} $textType,
      ${FavouritesFields.itemId} $textType,

      FOREIGN KEY (${FavouritesFields.userId}) REFERENCES $tableUser (${UserFields.id}) ON DELETE CASCADE,
       FOREIGN KEY (${FavouritesFields.itemId}) REFERENCES $tableItems (${ItemFields.id}) ON DELETE CASCADE
      )''');

    db.execute('''CREATE TABLE $tableOrders (

      ${OrderFields.id} $idType,
      ${OrderFields.userId} $textType,
      ${OrderFields.totalAmount} $doubleType,
      ${OrderFields.timeStamp} $textType,

      FOREIGN KEY (${OrderFields.userId}) REFERENCES $tableUser (${UserFields.id}) ON DELETE CASCADE

      )''');

    db.execute('''CREATE TABLE $tableOrderItems (
      ${OrderItemsFields.id} $idType,
      ${OrderItemsFields.orderId} $textType,
      ${OrderItemsFields.userId} $textType,
      ${OrderItemsFields.itemID} $textType,
      ${OrderItemsFields.quantity} $intType,
      ${OrderItemsFields.size} $textType,
      ${OrderItemsFields.priceAtOrderTime} $doubleType,
      
      FOREIGN KEY (${OrderItemsFields.orderId}) REFERENCES $tableOrders (${OrderFields.id}) ON DELETE CASCADE,
      FOREIGN KEY (${OrderItemsFields.userId}) REFERENCES $tableUser (${UserFields.id}) ON DELETE CASCADE,
       FOREIGN KEY (${OrderItemsFields.itemID}) REFERENCES $tableItems (${ItemFields.id}) ON DELETE CASCADE

      )''');

    db.execute('''

    CREATE TABLE $tablePriceList(
    
    ${PriceListFields.id} $textType,
    ${PriceListFields.itemID} $textType, 
    ${PriceListFields.size} $textType,
    ${PriceListFields.price} $doubleType
    
    )''');
  }

  Future<void> test() async {
    final db = await instance.database;
    final result = await db.query(tableUser);

    print(result);
  }

  Future<Item?> readItem(String id) async {
    final db = await AppDatabase.instance.database;

    final result = await db.query(
      tableItems,
      where: '${ItemFields.id}=?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      final price = await db.query(
        tablePriceList,
        where: '${PriceListFields.itemID} = ?',
        whereArgs: [id],
      );
      Map<String, String> priceList = {};
      for (var item in price) {
        priceList[item[PriceListFields.size] as String] =
            item[PriceListFields.price].toString();
      }

      return Item.fromJson(result.first, priceList);
    } else {
      return null;
    }
  }

  Future<void> insertUser(Map<String, Object> newUser) async {
    final db = await instance.database;
    await db.insert(tableUser, newUser);
  }

  Future<User?> readUser(String userEmail, String password) async {
    final db = await instance.database;
    final result = await db.query(
      tableUser,
      where: '${UserFields.email}= ? AND ${UserFields.password}=?',
      whereArgs: [userEmail, password],
    );
    if (result.isNotEmpty) {
      return User.fromJson(result.first);
    } else {
      return null;
    }
  }

  Future<User?> getCurrentUser(String id) async {
    final db = await instance.database;
    final result = await db.query(
      tableUser,
      where: '${UserFields.id}= ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return User.fromJson(result.first);
    } else {
      return null;
    }
  }

  Future<void> close() async {
    final db = await instance.database;
    await db.close();
  }
}
