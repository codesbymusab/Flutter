final tableCategories = 'categories';

class CategoryFields {
  static final String id = '_id';
  static final String name = 'name';
}

class Categories {
  final String id;
  final String name;
  const Categories({required this.id, required this.name});

  Map<String, Object> toJson() => {
    CategoryFields.id: id,
    CategoryFields.name: name,
  };

  static Categories fromJson(Map<String, Object?> json) => Categories(
    id: json['${CategoryFields.id}'] as String,
    name: json['${CategoryFields.name}'] as String,
  );
}
