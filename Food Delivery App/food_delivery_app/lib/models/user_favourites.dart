final String tableFavourites = 'favourites';

class FavouritesFields {
  static final String id = '_id';
  static final String userId = 'userid';
  static final String itemId = 'itemid';
}

class Favourites {
  final String id;
  final String userId;
  final String itemId;

  Favourites({required this.id, required this.userId, required this.itemId});

  Map<String, Object> toJson() => {
    FavouritesFields.id: id,
    FavouritesFields.itemId: itemId,
    FavouritesFields.userId: userId,
  };

  static Favourites fromJson(Map<String, Object?> json) {
    return Favourites(
      id: json[FavouritesFields.id] as String,
      userId: json[FavouritesFields.userId] as String,
      itemId: json[FavouritesFields.itemId] as String,
    );
  }
}
