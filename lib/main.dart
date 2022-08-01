import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/orders.dart';
import '../providers/cart.dart';
import '../providers/products.dart';
import '../screens/splash_screen.dart';
import '../screens/auth_screen.dart';
import '../screens/products_overview_screen.dart';
import '../screens/edit_product_screen.dart';
import '../screens/user_products_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/orders_screen.dart';
import '../helpers/custom_route.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        // ChangeNotifierProvider(
        //   create: (_) => Products(),
        // ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products(),
          update: (_, auth, product) => product!..update(auth),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        // ChangeNotifierProvider(
        //   create: (_) => Orders(),
        // ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders(),
          update: (_, auth, orders) => orders!..update(auth),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
              // primarySwatch: Colors.purple,
              // accentColor: Colors.deepOrange,
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
                  .copyWith(secondary: Colors.deepOrange),
              fontFamily: 'Lato',
              pageTransitionsTheme: PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: CustomPageTransitioBuilder(),
                  TargetPlatform.iOS: CustomPageTransitioBuilder(),
                },
              )),
          home: auth.isAuth
              ? ProductOverviewScren()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen()),
          routes: {
            // ignore: prefer_const_constructors
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScren.routeName: (ctx) => UserProductsScren(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
