import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:food_delivery_app/components/app_loading_indicator.dart';
import 'package:food_delivery_app/components/categories_list.dart';
import 'package:food_delivery_app/components/product_list.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/constants/images.dart';
import 'package:food_delivery_app/models/item_model.dart';
import 'package:food_delivery_app/services/item_services.dart';
import 'package:food_delivery_app/services/user_services.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  bool showSearchBar = false;
  late List<String> categoryNames;
  late List<Item> itemList;
  List<Item> searchedItems = [];

  @override
  void initState() {
    super.initState();
  }

  Future<bool> initializeData() async {
    final itemServices = context.read<ItemServices>();
    final authServices = context.read<AuthServices>();
    categoryNames = await itemServices.getCategoryNames();
    String selectedCategory = itemServices.selectedCategory;
    itemList = await itemServices.getItems(selectedCategory);
    final user = await authServices.user;
    if (user != null) {
      itemServices.readAllCartItems(user.id);
      itemServices.getFavouriteItems(user.id);
      itemServices.getPastOrders(user.id);
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final String selectedCategory = context
        .watch<ItemServices>()
        .selectedCategory;

    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        leading: showSearchBar == true
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _searchController.clear();
                    showSearchBar = !showSearchBar;
                  });
                },
                icon: Icon(Icons.arrow_back_ios),
              )
            : IconButton(
                onPressed: () {
                  ZoomDrawer.of(context)!.toggle();
                },
                icon: Icon(Icons.menu),
              ),
        title: showSearchBar
            ? Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: _searchController,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                        fillColor: const Color.fromARGB(255, 248, 232, 167),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: const Color.fromARGB(227, 0, 0, 0),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: const Color.fromARGB(209, 0, 0, 0),
                          ),
                        ),
                        hintText: 'Search...',
                      ),
                      autofocus: true,

                      onChanged: (text) async {
                        searchedItems = await context
                            .read<ItemServices>()
                            .searchItems(text);
                        setState(() {});
                      },
                      cursorColor: Colors.black,
                    ),
                  ),
                ],
              )
            : Text(
                'Food Ville',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: '',
                ),
              ),
        actions: [
          showSearchBar == false
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showSearchBar = !showSearchBar;
                    });
                  },
                  icon: Icon(CupertinoIcons.search, color: Colors.black),
                )
              : Padding(padding: EdgeInsetsGeometry.all(2)),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'cartpage');
            },
            icon: Icon(Icons.shopping_cart, color: Colors.black),
          ),
        ],
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
            if (asyncSnapshot.hasData) {
              return Center(
                child: Column(
                  spacing: 8,
                  children: [
                    SizedBox(height: 10),
                    if (showSearchBar == false) ...{
                      ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(20),
                        child: Image.asset(
                          backgroundImages[selectedCategory]!,
                          height: 140,
                          width: 350,
                          fit: BoxFit.fitWidth,
                        ),
                      ),

                      CategoryList(
                        categories: categoryNames,
                        selectedCategory: selectedCategory,
                      ),
                      Expanded(child: ProductList(itemList: itemList)),
                    } else ...{
                      searchedItems.isEmpty && _searchController.text.isNotEmpty
                          ? Center(
                              child: Text(
                                'No Item Found',
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineMedium,
                              ),
                            )
                          : Expanded(
                              child: ProductList(itemList: searchedItems),
                            ),
                    },
                  ],
                ),
              );
            } else {
              return AppLoadingIndicator(size: 50);
            }
          },
        ),
      ),
    );
  }
}
