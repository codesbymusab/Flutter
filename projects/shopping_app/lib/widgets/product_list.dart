import 'package:flutter/material.dart';
import 'package:shopping_app/global_variables.dart';
import 'package:shopping_app/pages/search_page.dart';
import 'package:shopping_app/widgets/product_card.dart';
import 'package:shopping_app/pages/product_detail_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = ['All', 'Bata', 'Servis', 'Endure'];
  late String selectedFilter;
  TextEditingController textControllerSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Theme.of(context).colorScheme.primary,
          child: Row(
            spacing: 12,
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Shoes\nCollection',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: TextField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search',
                    filled: true,
                    focusColor: Colors.white,
                    fillColor: Colors.white70,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(30),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54),
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(30),
                      ),
                    ),
                  ),

                  cursorColor: Colors.black,
                  controller: textControllerSearch,
                  onSubmitted: (value) {
                    if (textControllerSearch.text.isNotEmpty) {
                      textControllerSearch.clear();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SearchPage(searchedProduct: value),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: filters.length,
            itemBuilder: (context, index) {
              final filter = filters[index];
              return Padding(
                padding: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedFilter = filter;
                    });
                  },
                  child: (Chip(
                    backgroundColor: selectedFilter == filter
                        ? Theme.of(context).colorScheme.primary
                        : Color.fromRGBO(246, 244, 242, 1),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    label: Text(filter),
                    labelStyle: const TextStyle(fontSize: 16),
                    side: const BorderSide(
                      color: Color.fromRGBO(246, 244, 242, 0.635),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(30),
                    ),
                  )),
                ),
              );
            },
          ),
        ),

        Flexible(
          child: ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final String title = products[index]['title'];
              final int price = products[index]['price'];
              final String img = products[index]['imageUrl'];
              final int id = products[index]['id'];
              final String company = products[index]['company'];

              if (selectedFilter == 'All' || company == selectedFilter) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailPage(product: products[index]),
                        ),
                      );
                    },
                    child: ProductCard(
                      title: title,
                      price: price,
                      img: img,
                      id: id,
                    ),
                  ),
                );
              } else {
                return Padding(padding: EdgeInsetsGeometry.all(0));
              }
            },
          ),
        ),
      ],
    );
  }
}
