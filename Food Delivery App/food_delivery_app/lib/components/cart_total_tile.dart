import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/colors.dart';

class CartTotalTile extends StatelessWidget {
  final VoidCallback onPressed;
  final double total;
  final double deliveryTotal;
  const CartTotalTile({
    super.key,
    required this.total,
    required this.deliveryTotal,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Item Total: \$${total.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Text(
                  'Delivery Total: \$${deliveryTotal.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Text(
                  'Grand Total: \$${(deliveryTotal + total).toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: scaffoldColor,
                  ),
                  onPressed: onPressed,
                  child: Text('Place Order'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
