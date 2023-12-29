import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample_app/core/constants/strings.dart';
import 'package:flutter_sample_app/core/routes/navigator_routes.dart';
import 'package:flutter_sample_app/features/cart/bloc/cart_bloc.dart';
import 'package:flutter_sample_app/features/product_list/bloc/product_list_bloc.dart';
import 'package:flutter_sample_app/features/product_list/presentation/widgets/product_action_button_widget.dart';
import 'package:flutter_sample_app/features/product_list/presentation/widgets/product_tile_widget.dart';

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListBloc, ProductListState>(
      buildWhen: (previous, current) => current is ProductListSuccessState,
      builder: (context, state) {
        return ListView.builder(
          itemCount: (state as ProductListSuccessState).products.length,
          itemBuilder: (context, index) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.of(context).pushNamed(
              NavigatorRoutes.productDetail,
              arguments: state.products[index],
            ),
            child: ProductTileWidget(
              product: state.products[index],
              actionButton: BlocBuilder<CartBloc, CartState>(
                builder: (context, cartState) {
                  CartBloc cartBloc = context.read<CartBloc>();
                  bool isProductAdded = cartBloc.checkProductExists(
                      product: state.products[index]);
                  return ProductActionButtonWidget(
                      onPressed: () {
                        cartBloc.add(
                              isProductAdded
                                  ? RemoveProductFromCartEvent(
                                      product: state.products[index])
                                  : AddProductToCartEvent(
                                      product: state.products[index]),
                            );
                      },
                      text:
                          isProductAdded ? Strings.removeFromCart : Strings.addToCart);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
