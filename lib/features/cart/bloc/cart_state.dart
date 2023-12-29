part of 'cart_bloc.dart';

@immutable
abstract class CartState extends Equatable {
  @override
  List<Object> get props => [];
}

abstract class CartActionState extends CartState {}

class CartInitial extends CartState {}

class CartSuccessState extends CartState {
  final List<Product> products;

  CartSuccessState({required this.products});
}

class CartEmptyState extends CartState {}

class ProductAddedToCartActionState extends CartActionState {}

class ProductRemovedFromCartActionState extends CartActionState {}
