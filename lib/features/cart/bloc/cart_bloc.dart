import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:flutter_sample_app/features/product_list/data/models/product.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepositoryImp cartRepositoryImp;

  CartBloc(this.cartRepositoryImp) : super(CartInitial()) {
    on<GetProductsAddedInCartEvent>(getProductsAddedInCart);
    on<AddProductToCartEvent>(addProductToCart);
    on<RemoveProductFromCartEvent>(removeProductFromCartEvent);
  }

  List<Product> productsInCart = [];

  FutureOr<void> getProductsAddedInCart(
      GetProductsAddedInCartEvent event, Emitter<CartState> emit) async {
    productsInCart = await cartRepositoryImp.getCartProductList();
    if (productsInCart.isNotEmpty) {
      emit(CartSuccessState(products: productsInCart));
    } else {
      emit(CartEmptyState());
    }
  }

  FutureOr<void> addProductToCart(
      AddProductToCartEvent event, Emitter<CartState> emit) {
    if (!checkProductExists(product: event.product)) {
      productsInCart.add(event.product);
      cartRepositoryImp.updateProductsInCart(productsInCart);
      emit(ProductAddedToCartActionState());
      emit(CartSuccessState(products: productsInCart));
    }
  }

  FutureOr<void> removeProductFromCartEvent(
      RemoveProductFromCartEvent event, Emitter<CartState> emit) {
    productsInCart.removeWhere((element) => element.id == event.product.id);
    cartRepositoryImp.updateProductsInCart(productsInCart);
    emit(ProductRemovedFromCartActionState());
    if (productsInCart.isNotEmpty) {
      emit(CartSuccessState(products: productsInCart));
    } else {
      emit(CartEmptyState());
    }
  }

  bool checkProductExists({required product}) =>
      productsInCart.where((element) => element.id == product.id).isNotEmpty;

  int subTotalAmount() {
    int sum = 0;
    for (var element in productsInCart) {
      sum = sum + (element.price ?? 0);
    }
    return sum;
  }
}
