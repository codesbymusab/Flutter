import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/services/item_services.dart';
import 'package:food_delivery_app/services/user_services.dart';
import 'package:provider/provider.dart';

class FavouriteButton extends StatefulWidget {
  final String itemId;
  const FavouriteButton({super.key, required this.itemId});

  @override
  State<FavouriteButton> createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {
  @override
  Widget build(BuildContext context) {
    Future<bool> checkIfFavourite(String itemId) async {
      final user = await context.read<AuthServices>().user;
      if (user != null) {
        return await context.read<ItemServices>().isFavourite(user.id, itemId);
      }
      return false;
    }

    return FutureBuilder(
      future: checkIfFavourite(widget.itemId),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.hasData) {
          return IconButton(
            onPressed: () async {
              final user = await context.read<AuthServices>().user;
              if (user != null) {
                await context.read<ItemServices>().addORremoveToFavourites(
                  itemId: widget.itemId,
                  userId: user.id,
                );
                setState(() {});
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text(
                    asyncSnapshot.data == false
                        ? 'Item added to favourites successfully!!'
                        : 'Item removed from favourites successfully!!',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.favorite,
              color: asyncSnapshot.data == true ? Colors.red : Colors.black54,
            ),
          );
        } else {
          return Padding(padding: EdgeInsetsGeometry.all(0));
        }
      },
    );
  }
}
