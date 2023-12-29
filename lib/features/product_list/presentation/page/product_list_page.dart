import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample_app/core/constants/strings.dart';
import 'package:flutter_sample_app/core/routes/navigator_routes.dart';
import 'package:flutter_sample_app/core/widgets/app_bar_title.dart';
import 'package:flutter_sample_app/core/widgets/error_view_widget.dart';
import 'package:flutter_sample_app/core/widgets/loading_view_widget.dart';
import 'package:flutter_sample_app/features/cart/bloc/cart_bloc.dart';
import 'package:flutter_sample_app/features/product_list/bloc/product_list_bloc.dart';
import 'package:flutter_sample_app/features/product_list/data/datasources/product_data_sources.dart';
import 'package:flutter_sample_app/features/product_list/presentation/widgets/product_list_widget.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final ProductListBloc _productListBloc =
      ProductListBloc(ProductDataSourcesImpl());

  @override
  void initState() {
    _productListBloc.add(ProductListFetchProductsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: Strings.products),
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return Stack(
                alignment: Alignment.topRight,
                children: [
                  IconButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed(NavigatorRoutes.cart),
                    icon: Icon(
                      context.read<CartBloc>().productsInCart.isNotEmpty
                          ? Icons.shopping_cart
                          : Icons.shopping_cart_outlined,
                    ),
                  ),
                  if (context.read<CartBloc>().productsInCart.isNotEmpty)
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: ClipOval(
                          child: ColoredBox(
                        color: Theme.of(context).primaryColor,
                        child: Center(
                          child: Text(
                            '${context.read<CartBloc>().productsInCart.length}',
                            style: const TextStyle(
                              height: 1.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )),
                    )
                ],
              );
            },
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => _productListBloc,
        child: BlocBuilder<ProductListBloc, ProductListState>(
          builder: (context, state) {
            if (state is ProductListSuccessState) {
              return const ProductListWidget();
            } else if (state is ProductListLoadingState) {
              return const LoadingViewWidget();
            } else if (state is ProductListEmptyState) {
              return const ErrorViewWidget(
                  error: Strings.noProductsAreAvailableAtThisMoment);
            } else if (state is ProductListErrorState) {
              return ErrorViewWidget(error: state.errorMessage);
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
