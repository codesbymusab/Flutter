import 'package:food_delivery_app/models/item_model.dart';
import 'package:uuid/uuid.dart';

final List<Item> sampleMenu = [
  // 🍕 Pizzas
  Item(
    id: Uuid().v1(),
    name: 'Margherita',
    category: 'Pizzas',
    description: 'Classic pizza with fresh mozzarella, tomatoes, and basil.',
    priceList: {'Small': '8.99', 'Medium': '10.99', 'Large': '12.99'},
    imageUrl: 'assets/images/pizzas/pizza4.jpg',
  ),
  Item(
    id: Uuid().v1(),
    name: 'Pepperoni Feast',
    category: 'Pizzas',
    description:
        'Loaded with mozzarella and generous slices of spicy pepperoni.',
    priceList: {'Small': '9.99', 'Medium': '12.99', 'Large': '14.99'},
    imageUrl: 'assets/images/pizzas/pizza1.png',
  ),
  Item(
    id: Uuid().v1(),
    name: 'BBQ Chicken',
    category: 'Pizzas',
    description:
        'Grilled chicken, tangy BBQ sauce, red onions, and mozzarella.',
    priceList: {'Small': '8.99', 'Medium': '10.99', 'Large': '12.99'},
    imageUrl: 'assets/images/pizzas/pizza3.png',
  ),
  Item(
    id: Uuid().v1(),
    name: 'Four Cheese',
    category: 'Pizzas',
    description:
        'A rich blend of mozzarella, cheddar, parmesan, and gorgonzola.',
    priceList: {'Small': '10.99', 'Medium': '12.99', 'Large': '15.99'},
    imageUrl: 'assets/images/pizzas/pizza2.png',
  ),

  // 🍔 Burgers
  Item(
    id: Uuid().v1(),
    name: 'Classic Beef Burger',
    category: 'Burgers',
    description:
        'Juicy grilled beef patty with lettuce, tomato, cheese, and our signature sauce.',
    priceList: {'Single': '5.99', 'Double': '7.99', 'Triple': '9.49'},
    imageUrl: 'assets/images/burgers/burger1.png',
  ),
  Item(
    id: Uuid().v1(),
    name: 'Chicken Zinger Burger',
    category: 'Burgers',
    description:
        'Crispy fried chicken fillet with spicy mayo, lettuce, and pickles.',
    priceList: {'Single': '6.49', 'Double': '8.49', 'Triple': '9.99'},
    imageUrl: 'assets/images/burgers/burger2.png',
  ),
  Item(
    id: Uuid().v1(),
    name: 'Veggie Burger',
    category: 'Burgers',
    description:
        'Grilled vegetable patty with cheese, lettuce, tomato, and herb mayo.',
    priceList: {'Single': '5.49', 'Double': '6.99', 'Triple': '8.49'},
    imageUrl: 'assets/images/burgers/burger3.png',
  ),
  Item(
    id: Uuid().v1(),
    name: 'BBQ Bacon Burger',
    category: 'Burgers',
    description:
        'Smoky BBQ sauce, crispy bacon, cheddar cheese, and grilled onions.',
    priceList: {'Single': '6.99', 'Double': '8.99', 'Triple': '10.49'},
    imageUrl: 'assets/images/burgers/burger4.png',
  ),

  // 🍨 Desserts
  Item(
    id: Uuid().v1(),
    name: 'Chocolate Lava Cake',
    category: 'Desserts',
    description:
        'Warm, rich chocolate cake with a gooey molten center, served with powdered sugar.',
    priceList: {'Regular': '4.99', 'Large': '6.49'},
    imageUrl: 'assets/images/desserts/dessert1.png',
  ),
  Item(
    id: Uuid().v1(),
    name: 'Chocolate Chip Cookie',
    category: 'Desserts',
    description:
        'Freshly baked cookie with chunks of semi-sweet chocolate, crispy edges, and a soft center.',
    priceList: {'Regular': '1.99', 'Large': '3.49'},
    imageUrl: 'assets/images/desserts/dessert2.png',
  ),
  Item(
    id: Uuid().v1(),
    name: 'Ice Cream Sundae',
    category: 'Desserts',
    description:
        'Creamy vanilla ice cream topped with chocolate syrup, nuts, and a cherry on top.',
    priceList: {'Regular': '3.99', 'Large': '5.49'},
    imageUrl: 'assets/images/desserts/dessert3.png',
  ),

  // 🥤 Drinks
  Item(
    id: Uuid().v1(),
    name: 'Pepsi',
    category: 'Drinks',
    description: 'Refreshing cola beverage with a bold, crisp taste.',
    priceList: {'Can': '1.49', 'Bottle': '2.49'},
    imageUrl: 'assets/images/drinks/drink1.png',
  ),
  Item(
    id: Uuid().v1(),
    name: 'Sprite',
    category: 'Drinks',
    description: 'Lemon-lime soda with a clean, crisp taste.',
    priceList: {'Can': '1.49', 'Bottle': '2.49'},
    imageUrl: 'assets/images/drinks/drink2.png',
  ),
  Item(
    id: Uuid().v1(),
    name: 'Fanta',
    category: 'Drinks',
    description: 'Orange-flavored soda with a fruity, bubbly kick.',
    priceList: {'Can': '1.49', 'Bottle': '2.49'},
    imageUrl: 'assets/images/drinks/drink3.png',
  ),
];
