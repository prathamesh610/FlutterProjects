import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    // Collecting ID by Named Routes
    final productId = ModalRoute.of(context).settings.arguments as String;

    // You can set listen in of(contx) to false because here you dont want to rebuild
    // the screen, you just wat to tap into the info passed. So set listen to false
    // inorder to make apps build less number of times and set it true if necessary.
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
    );
  }
}
