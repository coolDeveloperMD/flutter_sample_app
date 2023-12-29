import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample_app/core/constants/strings.dart';
import 'package:flutter_sample_app/core/widgets/app_bar_title.dart';
import 'package:flutter_sample_app/core/widgets/error_view_widget.dart';
import 'package:flutter_sample_app/features/cart/bloc/cart_bloc.dart';
import 'package:flutter_sample_app/features/cart/presentation/widgets/cart_product_list_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: Strings.cart),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        bloc: context.read<CartBloc>()..add(GetProductsAddedInCartEvent()),
        builder: (context, state) {
          if (state is CartSuccessState) {
            return const CartProductListWidget();
          } else if (state is CartEmptyState) {
            return const ErrorViewWidget(
              error: Strings.noProductsAreAvailableInCart,
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
