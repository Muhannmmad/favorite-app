import 'package:favorites_app/screens/favorites.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:favorites_app/models/product.dart';

class ProductsScreen extends StatelessWidget {
  final List<Product> products = [
    Product(id: '1', name: 'Banane'),
    Product(id: '2', name: 'Apfel'),
    Product(id: '3', name: 'Erdbeere'),
    Product(id: '4', name: 'Birne'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          Consumer<FavoritesProvider>(
            builder: (context, favoritesProvider, _) {
              final favoriteCount = favoritesProvider.favoriteIds.length;
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite),
                    onPressed: () {
                      Navigator.pushNamed(context, '/favorites');
                    },
                  ),
                  if (favoriteCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                        child: Text(
                          favoriteCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(product.name),
              trailing: Consumer<FavoritesProvider>(
                builder: (context, favoritesProvider, _) {
                  final isFavorite =
                      favoritesProvider.favoriteIds.contains(product.id);
                  return IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : null,
                    ),
                    onPressed: () {
                      favoritesProvider.toggleFavorite(product.id);
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
