final String tablePriceList = 'pricelist';

class PriceListFields {
  static final String id = '_id';
  static final String itemID = 'itemid';
  static final String size = 'size';
  static final String price = 'price';
}

class PriceList {
  final String id;
  final String itemID;
  final String size;
  final double price;

  PriceList({
    required this.id,
    required this.size,
    required this.price,
    required this.itemID,
  });

  Map<String, Object> toJson() => {
    PriceListFields.id: id,
    PriceListFields.itemID: itemID,
    PriceListFields.size: size,
    PriceListFields.price: price,
  };

  static PriceList fromJson(Map<String, Object?> json) {
    return PriceList(
      id: json[PriceListFields.id] as String,
      price: json[PriceListFields.price] as double,
      itemID: json[PriceListFields.itemID] as String,
      size: json[PriceListFields.size] as String,
    );
  }
}
