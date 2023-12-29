import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample_app/features/product_list/bloc/product_list_bloc.dart';
import 'package:flutter_sample_app/features/product_list/data/datasources/product_data_sources.dart';
import 'package:flutter_sample_app/features/product_list/data/models/product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_list_bloc_test.mocks.dart';

@GenerateMocks([ProductDataSources])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  final mockProductDataSources = MockProductDataSources();
  late ProductListBloc productListBloc;
  setUp(() {
    productListBloc = ProductListBloc(mockProductDataSources);
  });
  group('product initial event', () {
    blocTest<ProductListBloc, ProductListState>(
      'Fetched product list successfully',
      build: () {
        when(mockProductDataSources.getProducts()).thenAnswer(
          (realInvocation) async => [
            Product(
              id: 1,
              title: 'iPhone 9',
              description: 'An apple mobile which is nothing like apple',
              price: 549,
              rating: 4,
              thumbnail:
                  'https://i.dummyjson.com/data/products/1/thumbnail.jpg',
              youtubeVideo: 'https://www.youtube.com/watch?v=wZ8jzsdAmCI',
            )
          ],
        );
        return productListBloc;
      },
      act: (bloc) {
        bloc.add(ProductListFetchProductsEvent());
      },
      wait: const Duration(seconds: 2),
      expect: () => [
        ProductListLoadingState(),
        ProductListSuccessState(products: [
          Product(
            id: 1,
            title: 'iPhone 9',
            description: 'An apple mobile which is nothing like apple',
            price: 549,
            rating: 4,
            thumbnail: 'https://i.dummyjson.com/data/products/1/thumbnail.jpg',
            youtubeVideo: 'https://www.youtube.com/watch?v=wZ8jzsdAmCI',
          )
        ]),
      ],
    );
    blocTest<ProductListBloc, ProductListState>(
      'Empty product list',
      build: () {
        when(mockProductDataSources.getProducts()).thenAnswer(
          (realInvocation) async => [],
        );
        return productListBloc;
      },
      act: (bloc) {
        bloc.add(ProductListFetchProductsEvent());
      },
      wait: const Duration(seconds: 2),
      expect: () => [
        ProductListLoadingState(),
        ProductListEmptyState(),
      ],
    );
    blocTest<ProductListBloc, ProductListState>(
      'Exception generated while getting products',
      build: () {
        when(mockProductDataSources.getProducts())
            .thenThrow(Exception('error'));
        return productListBloc;
      },
      act: (bloc) {
        bloc.add(ProductListFetchProductsEvent());
      },
      wait: const Duration(seconds: 2),
      expect: () => [
        ProductListLoadingState(),
        ProductListErrorState(errorMessage: 'error message'),
      ],
    );
  });
}
