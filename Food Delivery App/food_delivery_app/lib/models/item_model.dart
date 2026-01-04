import 'package:food_delivery_app/models/price_list_model.dart';

final String tableItems = 'items';

class ItemFields {
  static final String id = '_id';
  static final String name = 'name';
  static final String category = 'category';
  static final String description = 'description';
  static final String imageUrl = 'imageurl';
}

class Item {
  final String id;
  final String name;
  final String category;
  final String description;
  final String imageUrl;
  final Map<String, String> priceList;

  Item({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.priceList,
    required this.imageUrl,
  });

  Map<String, Object> toJson() => {
    ItemFields.id: id,
    ItemFields.name: name,
    ItemFields.description: description,
    ItemFields.imageUrl: imageUrl,
    ItemFields.category: category,
  };

  static Item fromJson(
    Map<String, Object?> itemJson,
    Map<String, Object?> priceJson,
  ) {
    return Item(
      id: itemJson[ItemFields.id] as String,
      name: itemJson[ItemFields.name] as String,
      category: itemJson[ItemFields.category] as String,
      description: itemJson[ItemFields.description] as String,
      imageUrl: itemJson[ItemFields.imageUrl] as String,
      priceList: priceJson as Map<String, String>,
    );
  }
}
