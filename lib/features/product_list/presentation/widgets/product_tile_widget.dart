import 'package:flutter/material.dart';
import 'package:flutter_sample_app/core/widgets/rating_bar_widget.dart';
import 'package:flutter_sample_app/features/product_list/data/models/product.dart';

class ProductTileWidget extends StatelessWidget {
  final Product product;
  final Widget actionButton;

  const ProductTileWidget(
      {super.key, required this.product, required this.actionButton});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: double.maxFinite,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
            child: (product.thumbnail ?? '').isNotEmpty
                ? Image.network(
                    product.thumbnail ?? '',
                    width: 180,
                    height: 180,
                    fit: BoxFit.cover,
                  )
                : const SizedBox(
                    width: 240,
                    height: 180,
                    child: Icon(Icons.image, size: 180, color: Colors.grey),
                  ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 4,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        product.title ?? '',
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      RatingBarWidget(rating: product.rating ?? 0),
                      const SizedBox(
                        height: 4,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '\$ ',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            TextSpan(
                              text: '${product.price ?? 0}',
                              style: Theme.of(context).textTheme.titleLarge,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                actionButton,
                const SizedBox(
                  height: 4,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 8,
          ),
        ],
      ),
    );
  }
}
