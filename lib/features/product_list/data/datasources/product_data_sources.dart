import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_sample_app/features/product_list/data/models/product.dart';

abstract class ProductDataSources {
  Future<List<Product>> getProducts();
}

class ProductDataSourcesImpl extends ProductDataSources {
  @override
  Future<List<Product>> getProducts() async {
    List<Product> products = [];
    final String response =
    await rootBundle.loadString('assets/src/products.json');
    List<dynamic> decodedResponse = await jsonDecode(response);
    for (var element in decodedResponse) {
      products.add(Product.fromJson(element));
    }
    return products;
  }
}
