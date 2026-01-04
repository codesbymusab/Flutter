import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/product_list.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/services/item_services.dart';
import 'package:provider/provider.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final itemList = context.watch<ItemServices>().favouriteItems;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text(
          'Favourites',
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.topCenter,
            end: Alignment.bottomRight,
            colors: [Colors.white, backgroundColor],
          ),
        ),
        child: itemList.isEmpty
            ? Center(
                child: Text(
                  'No items added to Favourites',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              )
            : ProductList(itemList: itemList),
      ),
    );
  }
}
