final tableOrders = 'orders';

class OrderFields {
  static final String id = '_id';
  static final String userId = 'userid';
  static final String totalAmount = 'totalamount';
  static final String timeStamp = 'timestamp';
}

class Order {
  final String id;
  final String userId;
  final double totalAmount;
  final DateTime timeStamp;

  const Order({
    required this.id,
    required this.userId,
    required this.totalAmount,
    required this.timeStamp,
  });

  Map<String, Object> toJson() => {
    OrderFields.id: id,
    OrderFields.userId: userId,
    OrderFields.timeStamp: timeStamp.toIso8601String(),
    OrderFields.totalAmount: totalAmount,
  };

  static Order fromJson(Map<String, Object?> json) {
    return Order(
      id: json[OrderFields.id] as String,
      userId: json[OrderFields.userId] as String,
      totalAmount: json[OrderFields.totalAmount] as double,
      timeStamp: DateTime.parse(json[OrderFields.timeStamp] as String),
    );
  }
}
