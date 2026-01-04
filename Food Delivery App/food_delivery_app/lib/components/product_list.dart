import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/add_to_cart_dialouge.dart';
import 'package:food_delivery_app/components/favourite_button.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/models/item_model.dart';
import 'package:food_delivery_app/pages/item_detail_page.dart';

class ProductList extends StatelessWidget {
  final List<Item> itemList;
  const ProductList({super.key, required this.itemList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ItemDetailPage(item: itemList[index]);
                  },
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          itemList[index].name,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      FavouriteButton(itemId: itemList[index].id),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 200,
                          height: 100,
                          child: Text(
                            itemList[index].description,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        Spacer(),
                        Image.asset(
                          itemList[index].imageUrl,
                          width: 95,

                          fit: BoxFit.fitWidth,
                        ),
                      ],
                    ),
                  ),

                  Row(
                    spacing: 10,
                    children: [
                      Container(
                        width: 70,
                        height: 45,
                        decoration: BoxDecoration(
                          color: scaffoldColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(15),
                          ),
                        ),
                        child: IconButton(
                          tooltip: 'Add to Cart',
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  AddToCartDialouge(item: itemList[index]),
                            );
                          },
                          icon: Icon(Icons.add),
                        ),
                      ),
                      Text(
                        'From \$${itemList[index].priceList.values.toList()[0]}',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
