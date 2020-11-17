import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

import './edit_product_screen.dart';

import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';

class UserProductsScreen extends StatelessWidget {
  static const routNamed = '/user-products';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeNamed);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Consumer<Products>(
        builder: (_, product, ch) => Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemBuilder: (_, i) => Column(
              children: [
                UserProductItem(
                  product.items[i].title,
                  product.items[i].imageUrl,
                ),
                Divider(),
              ],
            ),
            itemCount: product.items.length,
          ),
        ),
      ),
    );
  }
}
