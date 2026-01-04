final tableCart = 'cart';

class CartItemsFields {
  static final String id = '_id';
  static final String userId = 'userid';
  static final String itemID = 'itemid';
  static final String quantity = 'quantity';
  static final String size = 'size';
}

class CartItems {
  final String id;
  final String userId;
  final String itemID;
  final int quantity;
  final String size;

  const CartItems({
    required this.id,
    required this.userId,
    required this.itemID,
    required this.quantity,
    required this.size,
  });

  Map<String, Object> toJson() => {
    CartItemsFields.id: id,
    CartItemsFields.itemID: itemID,
    CartItemsFields.quantity: quantity,
    CartItemsFields.userId: userId,
    CartItemsFields.size: size,
  };

  static CartItems fromJson(Map<String, Object?> json) {
    return CartItems(
      id: json[CartItemsFields.id] as String,
      userId: json[CartItemsFields.userId] as String,
      itemID: json[CartItemsFields.itemID] as String,
      quantity: json[CartItemsFields.quantity] as int,
      size: json[CartItemsFields.size] as String,
    );
  }
}
