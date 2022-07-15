import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_max/screens/product_detail_screen.dart';

import '../providers/products.dart';

import '../screens/products_overview_screen.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Products(),
      //Alternativa jer ne koristimo context u kreiranju Products() klase
      // return ChangeNotifierProvider.value(
      //   value: Products(),
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          // primaryColor: Colors.purple,
          // accentColor: Colors.deepOrange,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
              .copyWith(secondary: Colors.deepOrange),
          fontFamily: 'Lato',
        ),
        home: ProductOverviewScren(),
        routes: {
          // ignore: prefer_const_constructors
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
        },
      ),
    );
  }
}
