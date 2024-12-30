import 'package:favorites_app/models/product.dart';
import 'package:favorites_app/screens/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:favorites_app/screens/favorites.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FavoritesProvider(),
      child: MaterialApp(
        title: 'Favorites App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => ProductsScreen(),
          '/favorites': (context) => FavoritesScreen(
                products: [
                  Product(id: '1', name: 'Banane'),
                  Product(id: '2', name: 'Apfel'),
                  Product(id: '3', name: 'Erdbeere'),
                  Product(id: '4', name: 'Birne'),
                ],
              ),
        },
      ),
    );
  }
}
