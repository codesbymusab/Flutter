import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/models/item_model.dart';
import 'package:food_delivery_app/models/order_items.dart';
import 'package:food_delivery_app/models/order_model.dart';
import 'package:food_delivery_app/services/item_services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Order> pastOrders = context.read<ItemServices>().pastOrders;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text(
          'Order History',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: pastOrders.isEmpty
            ? Center(
                child: Text(
                  'No orders has been placed yet!!',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              )
            : ListView.builder(
                itemCount: pastOrders.length,
                itemBuilder: (context, index) {
                  late List<OrderItems> orderItems;
                  late List<Item> itemDetails;

                  Future<bool> getDetails(String orderId) async {
                    orderItems = await context
                        .read<ItemServices>()
                        .getOrderDetails(orderId);

                    itemDetails = await context
                        .read<ItemServices>()
                        .getOrderItems(orderItems);

                    return true;
                  }

                  return FutureBuilder(
                    future: getDetails(pastOrders[index].id),
                    builder: (context, asyncSnapshot) {
                      if (asyncSnapshot.hasData) {
                        return Container(
                          margin: EdgeInsets.only(top: 12),
                          decoration: BoxDecoration(
                            border: BoxBorder.all(
                              color: Colors.amberAccent,
                              width: 2.5,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadiusGeometry.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                                child: ColoredBox(
                                  color: scaffoldColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Orderd At: ${DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(pastOrders[index].timeStamp)}',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.displayMedium,
                                        ),
                                        Text(
                                          'Total: \$${pastOrders[index].totalAmount.toStringAsFixed(2)}',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.displayMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight: 90 * orderItems.length.toDouble(),
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: orderItems.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                        vertical: 5,
                                      ),
                                      child: SizedBox(
                                        height: 70,
                                        child: ListTile(
                                          tileColor: scaffoldColor,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              color: Colors.amberAccent,
                                              width: 2.5,
                                            ),
                                            borderRadius:
                                                BorderRadiusGeometry.circular(
                                                  12,
                                                ),
                                          ),
                                          leading: CircleAvatar(
                                            child: Image.asset(
                                              itemDetails[index].imageUrl,
                                            ),
                                          ),
                                          title: Text(
                                            itemDetails[index].name,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.displayMedium,
                                          ),

                                          subtitle: Text(
                                            '${orderItems[index].size} x${orderItems[index].quantity}',
                                          ),
                                          trailing: Text(
                                            '\$${orderItems[index].priceAtOrderTime}',
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                  ),
                                ),

                                width: double.infinity,
                                height: 30,
                                child: Center(
                                  child: InkResponse(
                                    onTap: () {
                                      context
                                          .read<ItemServices>()
                                          .addpastOrderItemsToCart(orderItems);
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          duration: Duration(seconds: 1),
                                          content: Text(
                                            'All items added to cart successfully!!',

                                            style: Theme.of(
                                              context,
                                            ).textTheme.displaySmall,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Add all to cart',
                                      style: TextStyle(
                                        color: Colors.amberAccent,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Center(
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                                color: Colors.black54,
                                strokeWidth: 4,
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
    );
  }
}
