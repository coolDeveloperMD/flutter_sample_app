import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample_app/features/product_list/data/datasources/product_data_sources.dart';
import 'package:flutter_sample_app/features/product_list/data/models/product.dart';

part 'product_list_event.dart';

part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final ProductDataSources productDataSources;
  ProductListBloc(this.productDataSources) : super(ProductListInitial()) {
    on<ProductListFetchProductsEvent>(productListFetchProductsEvent);
  }


  List<Product> products = [];

  FutureOr<void> productListFetchProductsEvent(
      ProductListFetchProductsEvent event,
      Emitter<ProductListState> emit) async {
    emit(ProductListLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    try {
      products = await productDataSources.getProducts();
      if (products.isNotEmpty) {
        emit(ProductListSuccessState(products: products));
      } else {
        emit(ProductListEmptyState());
      }
    } catch (e) {
      emit(ProductListErrorState(errorMessage: e.toString()));
    }
  }
}
