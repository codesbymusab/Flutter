import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/favourite_button.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/models/cart_items_model.dart';
import 'package:food_delivery_app/models/item_model.dart';
import 'package:food_delivery_app/services/item_services.dart';
import 'package:food_delivery_app/services/user_services.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ItemDetailPage extends StatefulWidget {
  final Item item;

  const ItemDetailPage({super.key, required this.item});

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  late String selectedSize;
  int quantity = 1;
  @override
  void initState() {
    selectedSize = widget.item.priceList.keys.toList()[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: [FavouriteButton(itemId: widget.item.id)],
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            decoration: BoxDecoration(color: Colors.black),
            child: Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  style: TextButton.styleFrom(overlayColor: Colors.amber),
                  onPressed: () async {
                    final itemServices = context.read<ItemServices>();
                    final user = await context.read<AuthServices>().user;
                    if (user != null) {
                      CartItems cartItem = CartItems(
                        id: Uuid().v1(),
                        userId: user.id,
                        itemID: widget.item.id,
                        quantity: quantity,
                        size: selectedSize,
                      );

                      await itemServices.addToCart(cartItem);
                      if (!mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text(
                            'Item added to cart successfully!!',

                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 590,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              color: scaffoldColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 60.0,
                horizontal: 30,
              ),
              child: Align(
                alignment: AlignmentDirectional.bottomStart,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Details:\n\n',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      TextSpan(
                        text: widget.item.description,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Container(
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Image.asset(widget.item.imageUrl, height: 235)),
                  Row(
                    spacing: 3,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (
                        int i = 0;
                        i < widget.item.priceList.length;
                        i++
                      ) ...{
                        TextButton(
                          onPressed: () {
                            setState(() {
                              selectedSize = widget.item.priceList.keys
                                  .toList()[i];
                            });
                          },
                          style: TextButton.styleFrom(
                            backgroundColor:
                                widget.item.priceList.keys.toList()[i] ==
                                    selectedSize
                                ? Colors.amberAccent
                                : const Color.fromARGB(124, 158, 158, 158),
                          ),
                          child: Text(
                            widget.item.priceList.keys.toList()[i],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      },
                    ],
                  ),
                  Text(
                    widget.item.name,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Row(
                    children: [
                      Text(
                        '\$ ${widget.item.priceList[selectedSize]!}',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Spacer(),
                      IconButton(
                        highlightColor: Colors.red,
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity -= 1;
                            });
                          }
                        },
                        icon: Icon(Icons.remove_circle, color: Colors.black),
                      ),
                      Text(
                        quantity.toString(),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      IconButton(
                        highlightColor: scaffoldColor,
                        onPressed: () {
                          setState(() {
                            quantity += 1;
                          });
                        },
                        icon: Icon(Icons.add_circle, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
