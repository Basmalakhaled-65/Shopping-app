import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/user_service.dart';
import '../services/api_service.dart';
import '../widgets/product_card.dart';
import '../widgets/shop_bottom_nav.dart';

class FavouriteScreen extends StatefulWidget { const FavouriteScreen({super.key}); @override State<FavouriteScreen> createState() => _FavouriteScreenState(); }
class _FavouriteScreenState extends State<FavouriteScreen> {
  late Future<List<Product>> future;
  @override void initState() { super.initState(); future = UserService.getFavorites(); }
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('My Favourite', style: TextStyle(fontSize: 16)), centerTitle: true), body: FutureBuilder<List<Product>>(future: future, builder: (context, snap) { if (snap.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator()); if (snap.hasError) return Center(child: Text(ApiService.errorMessage(snap.error!))); final list = snap.data ?? []; if (list.isEmpty) return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.favorite_border, size: 90, color: Colors.grey.shade300), const SizedBox(height: 12), const Text('There are no products in your favourite list', textAlign: TextAlign.center)])); return GridView.builder(padding: const EdgeInsets.all(12), itemCount: list.length, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 9, crossAxisSpacing: 9, childAspectRatio: .72), itemBuilder: (_, i) => ProductCard(product: list[i], onFavoritePressed: () async { try { await UserService.deleteFavorite(list[i].id); if (mounted) setState(() => future = UserService.getFavorites()); } catch (e) { if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ApiService.errorMessage(e)))); } })); }), bottomNavigationBar: const ShopBottomNav(selected: 2));
}