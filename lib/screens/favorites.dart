import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:favorites_app/models/product.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Product> products;

  const FavoritesScreen({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Consumer<FavoritesProvider>(
        builder: (context, favoritesProvider, _) {
          final favoriteProducts = products
              .where(
                (product) => favoritesProvider.favoriteIds.contains(product.id),
              )
              .toList();

          return favoriteProducts.isEmpty
              ? const Center(
                  child: Text('No favorites yet!'),
                )
              : ListView.builder(
                  itemCount: favoriteProducts.length,
                  itemBuilder: (context, index) {
                    final product = favoriteProducts[index];
                    return ListTile(
                      title: Text(product.name),
                    );
                  },
                );
        },
      ),
    );
  }
}

class FavoritesProvider with ChangeNotifier {
  final List<String> _favoriteIds = [];

  List<String> get favoriteIds => _favoriteIds;

  void toggleFavorite(String id) {
    if (_favoriteIds.contains(id)) {
      _favoriteIds.remove(id);
    } else {
      _favoriteIds.add(id);
    }
    notifyListeners();
  }
}
