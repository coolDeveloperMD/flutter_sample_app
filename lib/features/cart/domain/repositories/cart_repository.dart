import 'dart:convert';

import 'package:flutter_sample_app/core/local/shared_preference/app_preference.dart';
import 'package:flutter_sample_app/core/local/shared_preference/preference_constants.dart';
import 'package:flutter_sample_app/features/product_list/data/models/product.dart';

abstract class CartRepository {
  Future<void> updateProductsInCart(List<Product> products);

  Future<List<Product>> getCartProductList();
}

class CartRepositoryImp extends CartRepository {
  final AppPreference appPreference;

  CartRepositoryImp({
    required this.appPreference,
  });

  @override
  Future<void> updateProductsInCart(List<Product> products) async {
    appPreference.writeString(
        PreferenceConstants.cartProductListKey, jsonEncode(products));
  }

  @override
  Future<List<Product>> getCartProductList() async {
    String? cartJsonString =
        await appPreference.readString(PreferenceConstants.cartProductListKey);
    List<dynamic> decodedProductList = await jsonDecode(cartJsonString ?? '[]');
    List<Product> productsInCart = [];
    for (var element in decodedProductList) {
      productsInCart.add(Product.fromJson(element));
    }
    return productsInCart;
  }
}
