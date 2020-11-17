import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFav;
  ProductsGrid(this.showFav);
  @override
  Widget build(BuildContext context) {
    // Using Provider
    // Provider.of(context) setups a direct connection with the parent
    // This method and its childs will only rebuild if data changes here.
    // Not the entire widget tree!
    final productsData = Provider.of<Products>(context);
    final products = showFav ? productsData.favItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3 / 2,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        // create: (_) => products[i],
        value: products[i],
        child: ProductItem(),
      ),
      itemCount: products.length,
    );
  }
}
