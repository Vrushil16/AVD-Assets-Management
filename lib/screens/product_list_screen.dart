import 'package:asset_mangement/providers/product_provider.dart';
import 'package:asset_mangement/utils/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductProvider>(context).products;

    return Scaffold(
      appBar: const CommonAppBar(
        title: "Product List",
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text("Price: \$${product.price} - Location: ${product.location}"),
          );
        },
      ),
    );
  }
}
