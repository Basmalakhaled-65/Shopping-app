import 'package:flutter/material.dart';
import '../models/product.dart';
import '../presentation/facades/product_service.dart';
import '../core/network/api_client.dart';
import '../widgets/product_card.dart';

class CategoryScreen extends StatefulWidget { final String? category; const CategoryScreen({super.key, this.category}); @override State<CategoryScreen> createState() => _CategoryScreenState(); }
class _CategoryScreenState extends State<CategoryScreen> {
  late Future<List<Product>> future;
  @override void initState() { super.initState(); future = widget.category == null ? ProductService.getProducts() : ProductService.byCategory(widget.category!); }
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text(widget.category ?? 'Products', style: const TextStyle(fontSize: 16))), body: FutureBuilder<List<Product>>(future: future, builder: (context, snap) { if (snap.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator()); if (snap.hasError) return Center(child: Text(ApiClient.errorMessage(snap.error!))); final list = snap.data ?? []; if (list.isEmpty) return const Center(child: Text('No products in this category')); return GridView.builder(padding: const EdgeInsets.all(12), itemCount: list.length, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: .72), itemBuilder: (_, i) => ProductCard(product: list[i])); }));
}