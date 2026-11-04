import 'package:flutter/material.dart';

class EmptyFavouriteScreen extends StatelessWidget {
  const EmptyFavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('My Favourite', style: TextStyle(color: Colors.black, fontSize: 16)),
        centerTitle: true,
        leading: const BackButton(color: Colors.black),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.favorite_border, size: 100, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            const Text('There are no products in your\\nfavourite list', textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.black87)),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: const Color(0xFFFFA800),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 9,
        unselectedFontSize: 9,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favourite'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Account'),
        ],
        onTap: (index) {
          if (index == 1) Navigator.pushNamed(context, '/cart-empty');
          if (index == 2) {}
        },
      ),
    );
  }
}
