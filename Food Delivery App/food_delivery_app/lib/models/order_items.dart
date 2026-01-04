final tableOrderItems = 'orderitems';

class OrderItemsFields {
  static final String id = '_id';
  static final String userId = 'userid';
  static final String itemID = 'itemid';
  static final String quantity = 'quantity';
  static final String priceAtOrderTime = 'price';
  static final String orderId = 'orderid';
  static final String size = 'size';
}

class OrderItems {
  final String id;
  final String userId;
  final String orderId;
  final String itemID;
  final int quantity;
  final double priceAtOrderTime;
  final String size;

  const OrderItems({
    required this.id,
    required this.userId,
    required this.orderId,
    required this.itemID,
    required this.quantity,
    required this.priceAtOrderTime,
    required this.size,
  });
  Map<String, Object> toJson() => {
    OrderItemsFields.id: id,
    OrderItemsFields.itemID: itemID,
    OrderItemsFields.quantity: quantity,
    OrderItemsFields.userId: userId,
    OrderItemsFields.priceAtOrderTime: priceAtOrderTime,
    OrderItemsFields.orderId: orderId,
    OrderItemsFields.size: size,
  };

  static OrderItems fromJson(Map<String, Object?> json) {
    return OrderItems(
      id: json[OrderItemsFields.id] as String,
      orderId: json[OrderItemsFields.orderId] as String,
      userId: json[OrderItemsFields.userId] as String,
      itemID: json[OrderItemsFields.itemID] as String,
      quantity: json[OrderItemsFields.quantity] as int,
      priceAtOrderTime: json[OrderItemsFields.priceAtOrderTime] as double,
      size: json[OrderItemsFields.size] as String,
    );
  }
}
