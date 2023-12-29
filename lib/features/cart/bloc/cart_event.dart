part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class GetProductsAddedInCartEvent extends CartEvent {}

class AddProductToCartEvent extends CartEvent {
  final Product product;

  AddProductToCartEvent({required this.product});
}

class RemoveProductFromCartEvent extends CartEvent {
  final Product product;

  RemoveProductFromCartEvent({required this.product});
}
