import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_sample_app/features/cart/bloc/cart_bloc.dart';
import 'package:flutter_sample_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:flutter_sample_app/features/product_list/data/models/product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cart_bloc_test.mocks.dart';

@GenerateMocks([CartRepositoryImp])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late CartBloc cartBloc;
  late MockCartRepositoryImp mockCartRepositoryImp;
  setUp(() {
    mockCartRepositoryImp = MockCartRepositoryImp();
    cartBloc = CartBloc(mockCartRepositoryImp);
  });
  group('cart test', () {
    group('Get products added in cart', () {
      blocTest<CartBloc, CartState>(
        'cart empty',
        build: () {
          when(mockCartRepositoryImp.getCartProductList()).thenAnswer(
            (realInvocation) async => [],
          );
          return cartBloc;
        },
        act: (bloc) {
          bloc.add(GetProductsAddedInCartEvent());
        },
        expect: () => <CartState>[
          CartEmptyState(),
        ],
      );
      blocTest<CartBloc, CartState>(
        'cart success',
        build: () {
          when(mockCartRepositoryImp.getCartProductList()).thenAnswer(
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
              ),
            ],
          );
          return cartBloc;
        },
        act: (bloc) => bloc
          ..add(AddProductToCartEvent(
            product: Product(
              id: 1,
              title: 'iPhone 9',
              description: 'An apple mobile which is nothing like apple',
              price: 549,
              rating: 4,
              thumbnail:
                  'https://i.dummyjson.com/data/products/1/thumbnail.jpg',
              youtubeVideo: 'https://www.youtube.com/watch?v=wZ8jzsdAmCI',
            ),
          ))
          ..add(GetProductsAddedInCartEvent()),
        expect: () => <CartState>[
          ProductAddedToCartActionState(),
          CartSuccessState(products: [
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
          ])
        ],
      );
    });
    blocTest(
      'update product to cart event',
      build: () {
        when(mockCartRepositoryImp.updateProductsInCart([
          Product(
            id: 1,
            title: 'iPhone 9',
            description: 'An apple mobile which is nothing like apple',
            price: 549,
            rating: 4,
            thumbnail: 'https://i.dummyjson.com/data/products/1/thumbnail.jpg',
            youtubeVideo: 'https://www.youtube.com/watch?v=wZ8jzsdAmCI',
          )
        ])).thenAnswer(
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
            ),
          ],
        );
        return cartBloc;
      },
      act: (bloc) => bloc.add(
        AddProductToCartEvent(
          product: Product(
            id: 1,
            title: 'iPhone 9',
            description: 'An apple mobile which is nothing like apple',
            price: 549,
            rating: 4,
            thumbnail: 'https://i.dummyjson.com/data/products/1/thumbnail.jpg',
            youtubeVideo: 'https://www.youtube.com/watch?v=wZ8jzsdAmCI',
          ),
        ),
      ),
      expect: () => <CartState>[
        ProductAddedToCartActionState(),
        CartSuccessState(
          products: [
            Product(
              id: 1,
              title: 'iPhone 9',
              description: 'An apple mobile which is nothing like apple',
              price: 549,
              rating: 4,
              thumbnail:
                  'https://i.dummyjson.com/data/products/1/thumbnail.jpg',
              youtubeVideo: 'https://www.youtube.com/watch?v=wZ8jzsdAmCI',
            ),
          ],
        )
      ],
    );
    blocTest(
      'Remove product from cart event',
      build: () {
        when(mockCartRepositoryImp.updateProductsInCart([]))
            .thenAnswer((realInvocation) async => []);
        return cartBloc;
      },
      act: (bloc) => bloc
        ..add(
          AddProductToCartEvent(
            product: Product(
              id: 1,
              title: 'iPhone 9',
              description: 'An apple mobile which is nothing like apple',
              price: 549,
              rating: 4,
              thumbnail:
                  'https://i.dummyjson.com/data/products/1/thumbnail.jpg',
              youtubeVideo: 'https://www.youtube.com/watch?v=wZ8jzsdAmCI',
            ),
          ),
        )
        ..add(
          RemoveProductFromCartEvent(
            product: Product(
              id: 1,
              title: 'iPhone 9',
              description: 'An apple mobile which is nothing like apple',
              price: 549,
              rating: 4,
              thumbnail:
                  'https://i.dummyjson.com/data/products/1/thumbnail.jpg',
              youtubeVideo: 'https://www.youtube.com/watch?v=wZ8jzsdAmCI',
            ),
          ),
        ),
      expect: () => <CartState>[
        ProductAddedToCartActionState(),
        CartSuccessState(products: [
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
        ]),
        ProductRemovedFromCartActionState(),
        CartEmptyState(),
      ],
    );
  });
}
