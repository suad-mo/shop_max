import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_max/screens/edit_product_screen.dart';

import '../providers/products.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';

// ignore: use_key_in_widget_constructors
class UserProductsScren extends StatelessWidget {
  static const routeName = '/user-product';

  Future<void> _refreshProduct(BuildContext ctx) async {
    await Provider.of<Products>(ctx, listen: false).fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    // final productsData = Provider.of<Products>(context);
    print('rebuilding...');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshProduct(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshProduct(context),
                    child: Consumer<Products>(
                      builder: ((ctx, productsData, _) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              itemCount: productsData.items.length,
                              itemBuilder: (_, i) => Column(
                                children: <Widget>[
                                  UserProductItem(
                                    productsData.items[i].id,
                                    productsData.items[i].title,
                                    productsData.items[i].imageUrl,
                                    // () {
                                    //   productsData.deleteProduct(productsData.items[i].id);
                                    // },
                                  ),
                                  const Divider(),
                                ],
                              ),
                            ),
                          )),
                    ),
                  ),
      ),
    );
  }
}
