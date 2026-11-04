import 'package:flutter/material.dart';

class EmptyCartScreen extends StatelessWidget {
  const EmptyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('My Cart', style: TextStyle(color: Colors.black, fontSize: 16)),
        centerTitle: true,
        leading: const BackButton(color: Colors.black),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            const Text('Your cart is empty', style: TextStyle(fontSize: 12, color: Colors.black87)),
          ],
        ),
      ),
      bottomNavigationBar: _BottomNav(selected: 1),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final int selected;
  const _BottomNav({required this.selected});

  @override
  Widget build(BuildContext context) => BottomNavigationBar(
    currentIndex: selected,
    selectedItemColor: const Color(0xFFFFA800),
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: true,
    selectedFontSize: 9,
    unselectedFontSize: 9,
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
      BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favourite'),
      BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Account'),
    ],
    onTap: (index) {
      if (index == 2) Navigator.pushNamed(context, '/favourite-empty');
      if (index == 1) Navigator.pushNamed(context, '/cart-empty');
    },
  );
}
