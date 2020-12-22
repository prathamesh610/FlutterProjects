// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

import './edit_product_screen.dart';

import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';

class UserProductsScreen extends StatelessWidget {
  static const routNamed = '/user-products';
  Future<void> _refresh(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

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
      body: FutureBuilder(
        future: _refresh(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refresh(context),
                    child: Consumer<Products>(
                      builder: (_, product, ch) => Padding(
                        padding: EdgeInsets.all(8),
                        child: ListView.builder(
                          itemBuilder: (_, i) => Column(
                            children: [
                              UserProductItem(
                                product.items[i].id,
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
                  ),
      ),
    );
  }
}
