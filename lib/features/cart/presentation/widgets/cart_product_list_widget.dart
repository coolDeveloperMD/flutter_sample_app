import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample_app/core/constants/strings.dart';
import 'package:flutter_sample_app/core/routes/navigator_routes.dart';
import 'package:flutter_sample_app/features/cart/bloc/cart_bloc.dart';
import 'package:flutter_sample_app/features/product_list/presentation/widgets/product_action_button_widget.dart';
import 'package:flutter_sample_app/features/product_list/presentation/widgets/product_tile_widget.dart';

class CartProductListWidget extends StatelessWidget {
  const CartProductListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (previous, current) => current is CartSuccessState,
      builder: (context, state) {
        CartBloc cartBloc = context.read<CartBloc>();
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: (state as CartSuccessState).products.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(
                    NavigatorRoutes.productDetail,
                    arguments: state.products[index],
                  ),
                  child: ProductTileWidget(
                    product: state.products[index],
                    actionButton: ProductActionButtonWidget(
                      onPressed: () => context.read<CartBloc>().add(
                          RemoveProductFromCartEvent(
                              product: state.products[index])),
                      text: 'Remove',
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        Strings.subTotal,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '\$',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            TextSpan(
                              text: '${cartBloc.subTotalAmount()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    height: 48,
                    child: MaterialButton(
                      onPressed: () {},
                      color: Colors.yellow,
                      child: Text(
                        'Proceed to Buy (${state.products.length} items)',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
