import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/user_service.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onFavoritePressed;
  const ProductCard({super.key, required this.product, this.onFavoritePressed});
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () => Navigator.pushNamed(context, '/details', arguments: product),
    child: Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)), clipBehavior: Clip.antiAlias,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: Stack(fit: StackFit.expand, children: [
          Container(color: const Color(0xFFEAEAEA), child: product.image.isEmpty ? const Icon(Icons.shopping_bag_outlined, size: 55, color: Colors.grey) : Image.network(product.image, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const Icon(Icons.shopping_bag_outlined, size: 55, color: Colors.grey)),),
          Positioned(right: 5, top: 5, child: Material(color: Colors.white.withOpacity(.9), shape: const CircleBorder(), child: IconButton(iconSize: 18, visualDensity: VisualDensity.compact, icon: const Icon(Icons.favorite_border), onPressed: onFavoritePressed ?? () async { try { if (product.id.isEmpty) throw Exception('Product id is missing'); await UserService.addFavorite(product.id); if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to favourites'))); } catch (e) { if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString().replaceFirst('Exception: ', '')))); } }))),
        ])),
        Padding(padding: const EdgeInsets.fromLTRB(8, 7, 8, 2), child: Text(product.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600))),
        Padding(padding: const EdgeInsets.fromLTRB(8, 0, 8, 8), child: Text('EGP ${product.price.toStringAsFixed(0)}', style: const TextStyle(fontSize: 11))),
      ])),
  );
}