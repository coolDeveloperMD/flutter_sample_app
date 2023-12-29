part of 'product_list_bloc.dart';

@immutable
abstract class ProductListState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductListInitial extends ProductListState {}

class ProductListLoadingState extends ProductListState {}

class ProductListSuccessState extends ProductListState {
  final List<Product> products;

  ProductListSuccessState({required this.products});
}

class ProductListEmptyState extends ProductListState {}

class ProductListErrorState extends ProductListState {
  final String errorMessage;

  ProductListErrorState({required this.errorMessage});
}
