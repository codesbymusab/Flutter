import 'package:flutter/material.dart';
import 'package:shopping_app/pages/cart_page.dart';
import 'package:shopping_app/widgets/product_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> pages = [ProductList(), CartPage()];
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentPage, children: pages),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: BottomNavigationBar(
          currentIndex: currentPage,
          onTap: (value) {
            setState(() {
              currentPage = value;
            });
          },
          selectedFontSize: 0,
          unselectedFontSize: 0,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          backgroundColor: const Color.fromARGB(255, 211, 208, 208),
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home_filled),
            ),

            BottomNavigationBarItem(
              label: 'Cart',
              icon: Icon(Icons.shopping_bag_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
