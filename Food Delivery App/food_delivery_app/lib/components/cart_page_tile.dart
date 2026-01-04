import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/models/cart_items_model.dart';
import 'package:food_delivery_app/models/item_model.dart';
import 'package:food_delivery_app/services/item_services.dart';
import 'package:provider/provider.dart';

class CartPageTile extends StatelessWidget {
  final List<CartItems> cartItems;
  final Item tileItem;
  final int cartIndex;
  const CartPageTile({
    super.key,
    required this.cartItems,
    required this.tileItem,
    required this.cartIndex,
  });

  @override
  Widget build(BuildContext context) {
    void onPressedDelete(String itemId) async {
      return await context.read<ItemServices>().removeFromCart(itemId);
    }

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SizedBox(
          height: 150,
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.directional(
              topEnd: Radius.circular(20),
              bottomEnd: Radius.circular(20),
            ),
            child: Material(
              child: Slidable(
                enabled: true,
                endActionPane: ActionPane(
                  motion: StretchMotion(),
                  children: [
                    SlidableAction(
                      padding: EdgeInsets.all(25),
                      onPressed: (context) {
                        onPressedDelete(tileItem.id);
                      },

                      icon: Icons.delete,
                      backgroundColor: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.only(
                    top: 30,
                    bottom: 30,
                    right: 20,
                  ),
                  tileColor: Colors.amberAccent,

                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0, left: 15),
                    child: Text(
                      tileItem.name,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  trailing: Column(
                    children: [
                      Text(
                        cartItems[cartIndex].size,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Spacer(),
                      Text(
                        '\$${tileItem.priceList[cartItems[cartIndex].size]}',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      IconButton(
                        highlightColor: Colors.red,
                        onPressed: () async {
                          if (cartItems[cartIndex].quantity > 1) {
                            await context.read<ItemServices>().decreaseQuantity(
                              cartItems,
                              cartIndex,
                            );
                          }
                        },
                        icon: Icon(Icons.remove_circle, color: Colors.black),
                      ),
                      Text(
                        cartItems[cartIndex].quantity.toString(),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      IconButton(
                        highlightColor: scaffoldColor,
                        onPressed: () async {
                          await context.read<ItemServices>().increaseQuantity(
                            cartItems,
                            cartIndex,
                          );
                        },
                        icon: Icon(Icons.add_circle, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
