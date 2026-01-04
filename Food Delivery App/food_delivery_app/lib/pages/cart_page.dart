import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/cart_tile_image.dart';
import 'package:food_delivery_app/components/cart_total_tile.dart';
import 'package:food_delivery_app/components/completion_transition.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/models/cart_items_model.dart';
import 'package:food_delivery_app/models/item_model.dart';
import 'package:food_delivery_app/components/cart_page_tile.dart';
import 'package:food_delivery_app/services/item_services.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<Item?> getDetails(String id) async {
    final item = await context.read<ItemServices>().getItemDetails(id);

    return item;
  }

  void onPressedPlaceOrder() async {
    final itemServices = context.read<ItemServices>();
    if (itemServices.cartItems.isNotEmpty) {
      await context.read<ItemServices>().placeOrder();
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => CompletionTransition(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double total = context.watch<ItemServices>().getCartTotal;
    List<CartItems> cartItems = context.watch<ItemServices>().cartItems;
    double deliveryTotal = total * 0.2;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text('Cart', style: Theme.of(context).textTheme.headlineLarge),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      backgroundColor: Colors.amberAccent.shade100,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.topCenter,
            end: Alignment.bottomRight,
            colors: [Colors.white, backgroundColor],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(
                height: 400,
                child: cartItems.isEmpty
                    ? Center(
                        child: Text(
                          'Your cart is Empty',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      )
                    : ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          return FutureBuilder(
                            future: getDetails(cartItems[index].itemID),
                            builder: (context, asyncSnapshot) {
                              if (asyncSnapshot.hasData) {
                                return Row(
                                  children: [
                                    CartTileImage(
                                      imageUrl: asyncSnapshot.data!.imageUrl,
                                    ),
                                    CartPageTile(
                                      cartItems: cartItems,
                                      tileItem: asyncSnapshot.data!,
                                      cartIndex: index,
                                    ),
                                  ],
                                );
                              } else {
                                return Center(
                                  child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.black54,
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
              ),
              SizedBox(height: 40),
              CartTotalTile(
                total: total,
                deliveryTotal: deliveryTotal,
                onPressed: onPressedPlaceOrder,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
