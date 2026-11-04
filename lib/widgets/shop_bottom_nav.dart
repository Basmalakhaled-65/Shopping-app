import 'package:flutter/material.dart';
class ShopBottomNav extends StatelessWidget {
  final int selected;
  const ShopBottomNav({super.key, required this.selected});
  @override
  Widget build(BuildContext context) => BottomNavigationBar(currentIndex: selected, type: BottomNavigationBarType.fixed, selectedItemColor: const Color(0xFFFFA800), unselectedItemColor: Colors.grey, selectedFontSize: 9, unselectedFontSize: 9,
    items: const [BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'), BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'), BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favourite'), BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Account')],
    onTap: (i) { const routes = ['/home', '/cart', '/favourites', '/account']; if (i != selected) Navigator.pushReplacementNamed(context, routes[i]); });
}