import 'package:flutter/material.dart';
import '../models/product.dart';
import '../presentation/facades/product_service.dart';
import '../core/network/api_client.dart';
import '../widgets/product_card.dart';

class SearchScreen extends StatefulWidget { const SearchScreen({super.key}); @override State<SearchScreen> createState() => _SearchScreenState(); }
class _SearchScreenState extends State<SearchScreen> {
  String query = ''; late Future<List<Product>> future;
  @override void initState() { super.initState(); future = ProductService.getProducts(); }
  void search(String value) { setState(() { query = value; future = ProductService.search(value); }); }
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Product Search', style: TextStyle(fontSize: 16))), body: Column(children: [Padding(padding: const EdgeInsets.all(12), child: TextField(onChanged: search, decoration: InputDecoration(hintText: 'Search for products', prefixIcon: const Icon(Icons.search), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))))), Expanded(child: FutureBuilder<List<Product>>(future: future, builder: (context, snap) { if (snap.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator()); if (snap.hasError) return Center(child: Text(ApiClient.errorMessage(snap.error!))); final list = snap.data ?? []; if (list.isEmpty) return Center(child: Text(query.isEmpty ? 'No products found' : 'No results for "$query"')); return GridView.builder(padding: const EdgeInsets.all(12), itemCount: list.length, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 9, crossAxisSpacing: 9, childAspectRatio: .72), itemBuilder: (_, i) => ProductCard(product: list[i])); }))]));
}