import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/product_service.dart';
import '../services/api_service.dart';
import '../widgets/product_card.dart';
import '../widgets/shop_bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> products;
  late Future<List<String>> categories;

  @override
  void initState() {
    super.initState();
    products = ProductService.getProducts();
    categories = ProductService.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Let's Start Your Day",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const Text(
            'Categories',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 9),

          SizedBox(
            height: 38,
            child: FutureBuilder<List<String>>(
              future: categories,
              builder: (context, snap) {
                if (snap.hasError) {
                  return Center(
                    child: Text(ApiService.errorMessage(snap.error!)),
                  );
                }

                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: LinearProgressIndicator());
                }

                final items = snap.data ?? [];

                if (items.isEmpty) {
                  return const Center(
                    child: Text(
                      'No categories found',
                      style: TextStyle(fontSize: 11),
                    ),
                  );
                }

                return ListView(
                  scrollDirection: Axis.horizontal,
                  children: items.map((e) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 7),
                      child: ActionChip(
                        label: Text(e, style: const TextStyle(fontSize: 10)),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/categories',
                            arguments: e,
                          );
                        },
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'Popular Products',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 9),

          FutureBuilder<List<Product>>(
            future: products,
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.all(30),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (snap.hasError) {
                return Center(
                  child: Text(ApiService.errorMessage(snap.error!)),
                );
              }

              final list = snap.data ?? [];

              if (list.isEmpty) {
                return const Center(child: Text('No products found'));
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: list.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 9,
                  crossAxisSpacing: 9,
                  childAspectRatio: .72,
                ),
                itemBuilder: (context, i) {
                  return ProductCard(product: list[i]);
                },
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: const ShopBottomNav(selected: 0),
    );
  }
}
