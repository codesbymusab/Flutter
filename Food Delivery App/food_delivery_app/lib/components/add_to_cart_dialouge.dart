import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/cart_items_model.dart';
import 'package:food_delivery_app/models/item_model.dart';
import 'package:food_delivery_app/services/item_services.dart';
import 'package:food_delivery_app/services/user_services.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddToCartDialouge extends StatefulWidget {
  final Item item;
  const AddToCartDialouge({super.key, required this.item});

  @override
  State<AddToCartDialouge> createState() => _AddToCartDialougeState();
}

class _AddToCartDialougeState extends State<AddToCartDialouge> {
  late String selectedSize;

  @override
  @override
  void initState() {
    super.initState();
    selectedSize = widget.item.priceList.keys.toList()[0];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.amberAccent,
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          width: 320,
          height: 450,

          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(12),
                  child: Image.asset(
                    widget.item.imageUrl,
                    height: 150,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Flexible(
                child: ListView.builder(
                  itemCount: widget.item.priceList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: RadioListTile(
                        activeColor: Colors.black,
                        value: widget.item.priceList.keys.toList()[index],
                        groupValue: selectedSize,
                        onChanged: (value) {
                          setState(() {
                            selectedSize = value.toString();
                          });
                        },

                        title: Text(
                          widget.item.priceList.keys.toList()[index],
                          style: TextStyle(fontSize: 15),
                        ),
                        subtitle: Text(
                          widget.item.priceList.values.toList()[index],
                          style: TextStyle(fontSize: 15),
                        ),
                        shape: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black87),
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final user = await context.read<AuthServices>().user;
                  if (user != null) {
                    CartItems cartItem = CartItems(
                      id: Uuid().v1(),
                      userId: user.id,
                      itemID: widget.item.id,
                      quantity: 1,
                      size: selectedSize,
                    );
                    await context.read<ItemServices>().addToCart(cartItem);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text(
                          'Item added to cart successfully!!',

                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },

                child: Text(
                  'Add To Cart',
                  style: TextStyle(color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
