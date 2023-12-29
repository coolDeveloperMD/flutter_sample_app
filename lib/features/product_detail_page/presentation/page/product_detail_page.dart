import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample_app/core/constants/strings.dart';
import 'package:flutter_sample_app/core/widgets/app_bar_title.dart';
import 'package:flutter_sample_app/core/widgets/rating_bar_widget.dart';
import 'package:flutter_sample_app/core/widgets/youtube_player_view_widget.dart';
import 'package:flutter_sample_app/features/cart/bloc/cart_bloc.dart';
import 'package:flutter_sample_app/features/product_list/data/models/product.dart';
import 'package:flutter_sample_app/features/product_list/presentation/widgets/product_action_button_widget.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context)?.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: Strings.productDetail),
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            height: 280,
            child: YouTubePlayerViewWidget(url: product.youtubeVideo ?? ''),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.title ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '\$ ',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  TextSpan(
                                    text: '${product.price ?? 0}',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                RatingBarWidget(rating: product.rating ?? 0),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  '${product.rating ?? 0} ${Strings.ratings}',
                                  style: const TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(product.description ?? '',
                            style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      CartBloc cartBloc = context.read<CartBloc>();
                      bool isAddedToCart =
                          cartBloc.checkProductExists(product: product);
                      return ProductActionButtonWidget(
                          onPressed: () {
                            cartBloc.add(
                              isAddedToCart
                                  ? RemoveProductFromCartEvent(product: product)
                                  : AddProductToCartEvent(product: product),
                            );
                          },
                          text: isAddedToCart
                              ? Strings.removeFromCart
                              : Strings.addToCart);
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          )
        ],
      ),
    );
  }
}
