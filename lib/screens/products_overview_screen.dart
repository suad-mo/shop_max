import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../providers/cart.dart';
import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';

enum FilterOptions {
  favorites,
  all,
}

// ignore: use_key_in_widget_constructors
class ProductOverviewScren extends StatefulWidget {
  @override
  State<ProductOverviewScren> createState() => _ProductOverviewScrenState();
}

class _ProductOverviewScrenState extends State<ProductOverviewScren> {
  var _showOnlyFavorites = false;
  //var _isInit = true; >> Netreba dovoljno je uključiti (listen: false)
  var _isLoading = false;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final productsContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MyShop',
        ),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: const Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.favorites,
                child: Text('Only Favorites'),
              ),
              const PopupMenuItem(
                value: FilterOptions.all,
                child: Text('Show All'),
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              value: cart.itemCount.toString(),
              child: ch as Widget,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showOnlyFavorites),
    );
  }
}
