import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';

import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*
    Should use ChangeNotifierProvider with .value arg inorder to bind it with
    The corresponding value and doesnt require context.
    Also, in .value, the widget is built and discarded as and when required
    rather than just reusing of widget without .value
    But in main dart, we are not re-using this widget unlike from products_grid
    So, we don't use .value here. This is because, the app may get buggy or
    re-render everything unnecessarily
    ALSO, ChangeNotifierProvider automatically cleansup the widgets when no longer required
    inorder to save memory and avoid memory leaks.
    */
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        )
      ],
      // value: Products(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routName: (ctx) => CartScreen(),
          OrdersScreen.routNamed: (ctx) => OrdersScreen(),
          UserProductsScreen.routNamed: (ctx) => UserProductsScreen(),
          EditProductScreen.routeNamed: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}
