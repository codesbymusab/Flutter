import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/app_loading_indicator.dart';
import 'package:food_delivery_app/components/product_list.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/models/item_model.dart';
import 'package:food_delivery_app/services/item_services.dart';
import 'package:provider/provider.dart';

class AllProductsPage extends StatefulWidget {
  const AllProductsPage({super.key});

  @override
  State<AllProductsPage> createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  late final List<Item> itemList;
  Future<bool> initializeData() async {
    itemList = await context.read<ItemServices>().getItems('All');

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text('All', style: Theme.of(context).textTheme.headlineLarge),
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
        child: FutureBuilder(
          future: initializeData(),
          builder: (context, asyncSnapshot) {
            return asyncSnapshot.hasData
                ? ProductList(itemList: itemList)
                : AppLoadingIndicator(size: 30);
          },
        ),
      ),
    );
  }
}
