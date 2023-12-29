import 'package:flutter/material.dart';
import 'package:flutter_sample_app/features/cart/presentation/page/cart_page.dart';
import 'package:flutter_sample_app/features/product_detail_page/presentation/page/product_detail_page.dart';
import 'package:flutter_sample_app/features/product_list/presentation/page/product_list_page.dart';

class NavigatorRoutes {
  NavigatorRoutes._();

  static const String root = '/';
  static const String productList = '/product-list';
  static const String cart = '/cart';
  static const String productDetail = '/product-detail';

  static Map<String, WidgetBuilder> routes = {
    root: (context) => const ProductListPage(),
    productList: (context) => const ProductListPage(),
    cart: (context) => const CartPage(),
    productDetail: (context) => const ProductDetailPage(),
  };
}
