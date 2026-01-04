import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/sample_menu.dart';
import 'package:food_delivery_app/db/app_database.dart';
import 'package:food_delivery_app/models/cart_items_model.dart';
import 'package:food_delivery_app/models/categories.dart';
import 'package:food_delivery_app/models/item_model.dart';
import 'package:food_delivery_app/models/order_items.dart';
import 'package:food_delivery_app/models/order_model.dart';
import 'package:food_delivery_app/models/price_list_model.dart';
import 'package:food_delivery_app/models/user_favourites.dart';
import 'package:uuid/uuid.dart';

class ItemServices extends ChangeNotifier {
  String _selectedCategory = 'Pizzas';
  List<CartItems> _cartItems = [];
  List<Item> _favouriteItems = [];
  List<Order> _pastOrders = [];
  double _cartTotal = 0;

  String get selectedCategory => _selectedCategory;
  double get getCartTotal => _cartTotal;

  List<CartItems> get cartItems => List.unmodifiable(_cartItems);
  List<Item> get favouriteItems => List.unmodifiable(_favouriteItems);
  List<Order> get pastOrders => List.unmodifiable(_pastOrders);

  Future<void> changeCategory(String category) async {
    _selectedCategory = category;
    notifyListeners();
  }

  Future<void> addCategory(Categories newCategory) async {
    final db = await AppDatabase.instance.database;
    db.insert(tableCategories, newCategory.toJson());
  }

  Future<List<String>> getCategoryNames() async {
    final db = await AppDatabase.instance.database;

    final categories = await db.query(tableCategories);
    List<String> names = [];
    for (var category in categories) {
      names.add(Categories.fromJson(category).name);
    }
    return names;
  }

  Future<void> insertItems() async {
    final db = await AppDatabase.instance.database;
    final result = await db.query(tableItems);

    if (result.isEmpty) {
      for (var item in sampleMenu) {
        await db.insert(tableItems, item.toJson());
        item.priceList.forEach((size, price) async {
          await db.insert(
            tablePriceList,
            PriceList(
              id: Uuid().v1(),
              size: size,
              price: double.parse(price),
              itemID: item.id,
            ).toJson(),
          );
        });
      }
    }
  }

  Future<List<Item>> getItems(String category) async {
    final db = await AppDatabase.instance.database;

    List<Map<String, Object?>> result;

    if (category == 'All') {
      result = await db.query(tableItems);
    } else {
      result = await db.query(
        tableItems,
        where: '${ItemFields.category}=?',
        whereArgs: [category],
      );
    }

    List<Item> itemList = [];

    for (var item in result) {
      String id = item[ItemFields.id] as String;
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

      itemList.add(Item.fromJson(item, priceList));
    }
    return itemList;
  }

  Future<bool> initializeCategories() async {
    final db = await AppDatabase.instance.database;

    final result = await db.query(tableCategories);

    if (result.isEmpty) {
      await addCategory(Categories(id: Uuid().v1(), name: 'Pizzas'));
      await addCategory(Categories(id: Uuid().v1(), name: 'Burgers'));
      await addCategory(Categories(id: Uuid().v1(), name: 'Drinks'));
      await addCategory(Categories(id: Uuid().v1(), name: 'Desserts'));
    }
    return true;
  }

  Future<void> increaseQuantity(List<CartItems> items, index) async {
    final db = await AppDatabase.instance.database;
    final item = items[index];
    var result = await db.query(
      tableCart,
      where: '${CartItemsFields.itemID} = ? AND ${CartItemsFields.userId}= ?',
      whereArgs: [item.itemID, item.userId],
    );
    if (result.isNotEmpty) {
      final CartItems updatedItem = CartItems(
        id: item.id,
        userId: item.userId,
        itemID: item.itemID,
        quantity: item.quantity + 1,
        size: item.size,
      );

      db.update(
        tableCart,
        updatedItem.toJson(),
        where: '${CartItemsFields.id}=?',
        whereArgs: [result.first[CartItemsFields.id]],
      );
      _cartItems.remove(item);
      _cartItems.add(updatedItem);
    }
    updateCartTotal();
  }

  Future<void> decreaseQuantity(List<CartItems> items, index) async {
    final db = await AppDatabase.instance.database;
    final item = items[index];
    var result = await db.query(
      tableCart,
      where: '${CartItemsFields.itemID} = ? AND ${CartItemsFields.userId}= ?',
      whereArgs: [item.itemID, item.userId],
    );
    if (result.isNotEmpty) {
      final CartItems updatedItem = CartItems(
        id: item.id,
        userId: item.userId,
        itemID: item.itemID,
        quantity: item.quantity - 1,
        size: item.size,
      );

      db.update(
        tableCart,
        updatedItem.toJson(),
        where: '${CartItemsFields.id}=?',
        whereArgs: [result.first[CartItemsFields.id]],
      );
      _cartItems.remove(item);
      _cartItems.add(updatedItem);
    }
    updateCartTotal();
  }

  Future<void> removeFromCart(String itemId) async {
    final db = await AppDatabase.instance.database;
    await db.delete(
      tableCart,
      where: '${CartItemsFields.itemID}=?',
      whereArgs: [itemId],
    );
    _cartItems.removeWhere((item) => item.id == itemId);
  }

  Future<void> addToCart(CartItems item) async {
    final db = await AppDatabase.instance.database;

    var result = await db.query(
      tableCart,
      where:
          '${CartItemsFields.itemID} = ? AND ${CartItemsFields.userId}= ? AND ${CartItemsFields.size}=?',
      whereArgs: [item.itemID, item.userId, item.size],
    );
    if (result.isNotEmpty) {
      int oldQty = result.first[CartItemsFields.quantity] as int;
      final CartItems updatedItem = CartItems(
        id: item.id,
        userId: item.userId,
        itemID: item.itemID,
        quantity: item.quantity + oldQty,
        size: item.size,
      );

      db.update(
        tableCart,
        updatedItem.toJson(),
        where: '${CartItemsFields.id}=?',
        whereArgs: [result.first[CartItemsFields.id]],
      );

      _cartItems.remove(item);
      _cartItems.add(updatedItem);
    } else {
      await db.insert(tableCart, item.toJson());
      _cartItems.add(item);
    }
    notifyListeners();
  }

  Future<void> readAllCartItems(String userId) async {
    final db = await AppDatabase.instance.database;

    final result = await db.query(
      tableCart,
      where: '${CartItemsFields.userId}=?',
      whereArgs: [userId],
    );

    _cartItems = result.map((json) => CartItems.fromJson(json)).toList();
    updateCartTotal();
  }

  Future<Item?> getItemDetails(String id) async {
    final db = AppDatabase.instance;
    return await db.readItem(id);
  }

  Future<void> updateCartTotal() async {
    double total = 0;
    for (var item in cartItems) {
      final itemDetails = await getItemDetails(item.itemID);
      if (itemDetails != null) {
        total +=
            double.parse(itemDetails.priceList[item.size]!) * item.quantity;
      }
    }
    _cartTotal = total;
    notifyListeners();
  }

  Future<void> placeOrder() async {
    Order order = Order(
      id: Uuid().v1(),
      userId: cartItems.first.userId,
      totalAmount: _cartTotal,
      timeStamp: DateTime.now(),
    );
    final db = await AppDatabase.instance.database;

    await db.insert(tableOrders, order.toJson());
    _pastOrders.add(order);
    for (var item in cartItems) {
      final price = await db.query(
        tablePriceList,
        where: '${PriceListFields.itemID}=?',
        whereArgs: [item.itemID],
      );
      if (price.isNotEmpty) {
        OrderItems orderItem = OrderItems(
          id: Uuid().v1(),
          userId: item.userId,
          orderId: order.id,
          itemID: item.itemID,
          quantity: item.quantity,
          priceAtOrderTime: PriceList.fromJson(price.first).price,
          size: item.size,
        );
        await db.insert(tableOrderItems, orderItem.toJson());
      }
    }
    db.delete(tableCart);
    _cartItems = [];
    updateCartTotal();
  }

  Future<bool> isFavourite(String userId, String itemId) async {
    final db = await AppDatabase.instance.database;

    final result = await db.query(
      tableFavourites,
      where: '${FavouritesFields.itemId}=? AND ${FavouritesFields.userId}=?',
      whereArgs: [itemId, userId],
    );

    return result.isNotEmpty ? true : false;
  }

  Future<void> addORremoveToFavourites({
    required String userId,
    required String itemId,
  }) async {
    final db = await AppDatabase.instance.database;
    final result = await db.query(
      tableFavourites,
      where: '${FavouritesFields.itemId}=? AND ${FavouritesFields.userId}=?',
      whereArgs: [itemId, userId],
    );
    if (result.isNotEmpty) {
      db.delete(
        tableFavourites,
        where: '${FavouritesFields.itemId}=? AND ${FavouritesFields.userId}=?',
        whereArgs: [itemId, userId],
      );
      final item = await getItemDetails(
        result.first[FavouritesFields.itemId] as String,
      );
      _favouriteItems.remove(item);
    } else {
      Favourites favourite = Favourites(
        id: Uuid().v1(),
        userId: userId,
        itemId: itemId,
      );
      await db.insert(tableFavourites, favourite.toJson());
      final item = await getItemDetails(itemId);
      if (item != null) {
        _favouriteItems.add(item);
      }
    }

    notifyListeners();
  }

  Future<void> getFavouriteItems(String userId) async {
    List<Item> itemList = [];
    final db = await AppDatabase.instance.database;

    final favourites = await db.query(
      tableFavourites,
      where: '${FavouritesFields.userId}=?',
      whereArgs: [userId],
    );

    if (favourites.isNotEmpty) {
      for (var favourite in favourites) {
        final item = await db.query(
          tableItems,
          where: '${ItemFields.id}=?',
          whereArgs: [favourite[FavouritesFields.itemId]],
        );
        if (item.isNotEmpty) {
          String id = item.first[ItemFields.id] as String;
          final prices = await db.query(
            tablePriceList,
            where: '${PriceListFields.itemID} = ?',
            whereArgs: [id],
          );
          Map<String, String> priceList = {};
          for (var price in prices) {
            priceList[price[PriceListFields.size] as String] =
                price[PriceListFields.price].toString();
          }

          itemList.add(Item.fromJson(item.first, priceList));
        }
      }
    }

    _favouriteItems = itemList;
  }

  Future<void> getPastOrders(String userId) async {
    final db = await AppDatabase.instance.database;

    final result = await db.query(
      tableOrders,
      where: '${OrderFields.userId}=?',
      whereArgs: [userId],
    );
    _pastOrders = result.map((order) => Order.fromJson(order)).toList();
  }

  Future<List<OrderItems>> getOrderDetails(String orderId) async {
    final db = await AppDatabase.instance.database;

    List<OrderItems> items = [];

    final result = await db.query(
      tableOrderItems,
      where: '${OrderItemsFields.orderId}=?',
      whereArgs: [orderId],
    );
    if (result.isNotEmpty) {
      for (var item in result) {
        items.add(OrderItems.fromJson(item));
      }
    }
    return items;
  }

  Future<List<Item>> getOrderItems(List<OrderItems> orderItems) async {
    List<Item> items = [];

    for (var item in orderItems) {
      final result = await getItemDetails(item.itemID);
      if (result != null) {
        items.add(result);
      }
    }
    return items;
  }

  Future<void> addpastOrderItemsToCart(List<OrderItems> orderItems) async {
    final db = await AppDatabase.instance.database;
    for (var item in orderItems) {
      CartItems cartItem = CartItems(
        id: Uuid().v1(),
        userId: item.userId,
        itemID: item.itemID,
        quantity: item.quantity,
        size: item.size,
      );
      await db.insert(tableCart, cartItem.toJson());
    }
    await readAllCartItems(orderItems.first.userId);
  }

  Future<List<Item>> searchItems(String keyword) async {
    List<Item> searchedItems = [];

    final db = await AppDatabase.instance.database;

    final result = await db.rawQuery(
      'SELECT * FROM $tableItems WHERE ${ItemFields.name} LIKE ?',
      ['%$keyword%'],
    );

    for (var item in result) {
      final itemDetails = await getItemDetails(item[ItemFields.id] as String);
      if (itemDetails != null) {
        searchedItems.add(itemDetails);
      }
    }
    return searchedItems;
  }
}
