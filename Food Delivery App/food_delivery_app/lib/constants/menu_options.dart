import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/menu_option.dart';

class MenuOptions {
  static const home = MenuOption(
    icon: Icons.home,
    title: "Home",
    route: 'mainpage',
  );
  static const cart = MenuOption(
    icon: Icons.shopping_cart,
    title: "My Cart",
    route: 'cartpage',
  );
  static const order = MenuOption(
    icon: Icons.today,
    title: "Order History",
    route: 'orderhistory',
  );
  static const favorite = MenuOption(
    icon: Icons.star,
    title: "Favorites",
    route: 'favourites',
  );
  static const faq = MenuOption(icon: Icons.help, title: "FAQs", route: 'faqs');
  static const support = MenuOption(
    icon: Icons.phone,
    title: "Help",
    route: 'help_page',
  );
  static const setting = MenuOption(
    icon: Icons.settings,
    title: "Setting",
    route: 'settingspage',
  );
  static const logout = MenuOption(
    icon: Icons.logout,
    title: "Logout",
    route: 'logoutpage',
  );

  static const allOptions = [home, cart, order, favorite, faq, support, logout];
}
