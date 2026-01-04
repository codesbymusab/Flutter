import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/constants/images.dart';
import 'package:food_delivery_app/services/item_services.dart';
import 'package:provider/provider.dart';

class CategoryList extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  const CategoryList({
    super.key,
    required this.categories,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Categories',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Spacer(),
              Text('View All', style: Theme.of(context).textTheme.labelMedium),

              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'allitemspage');
                },
                icon: Icon(
                  CupertinoIcons.arrow_right_square_fill,
                  color: Colors.deepOrangeAccent,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    context.read<ItemServices>().changeCategory(
                      categories[index],
                    );
                  },
                  child: Card(
                    color: categories[index] == selectedCategory
                        ? scaffoldColor
                        : Colors.white,

                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25.0,
                        vertical: 10,
                      ),
                      child: Column(
                        spacing: 5,
                        children: [
                          Image.asset(
                            categoryImages[categories[index]]!,
                            height: 60,
                          ),
                          Text(
                            categories[index],
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          Stack(
                            children: [
                              Icon(
                                Icons.circle,
                                color: categories[index] == selectedCategory
                                    ? Colors.white
                                    : Colors.deepOrangeAccent,
                                size: 32,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: categories[index] == selectedCategory
                                      ? Colors.deepOrangeAccent
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
