import 'package:flutter/material.dart';
import 'package:shopping_app/global_variables.dart';
import 'package:shopping_app/pages/product_detail_page.dart';
import 'package:shopping_app/widgets/product_card.dart';

class SearchPage extends StatefulWidget {
  final String searchedProduct;
  const SearchPage({super.key, required this.searchedProduct});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

List<Map<String, dynamic>> searchProducts(String searchedProduct) {
  List<Map<String, dynamic>> searchedProducts = [];

  for (var product in products) {
    if (product['title'].contains(searchedProduct.toString()) ||
        product['company'].contains(searchedProduct.toString())) {
      searchedProducts.add(product);
    }
  }
  return searchedProducts;
}

class _SearchPageState extends State<SearchPage> {
  late List<Map<String, dynamic>> searchedProducts;
  TextEditingController textControllerSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchedProducts = searchProducts(widget.searchedProduct);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black87),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Search'),
        centerTitle: true,
      ),
      body: Expanded(
        child: searchedProducts.isEmpty
            ? Center(
                child: Center(
                  child: Text(
                    'No Products Found',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: searchedProducts.length,
                itemBuilder: (context, index) {
                  final String title = searchedProducts[index]['title'];
                  final int price = searchedProducts[index]['price'];
                  final String img = searchedProducts[index]['imageUrl'];
                  final int id = searchedProducts[index]['id'];

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
                },
              ),
      ),
    );
  }
}
