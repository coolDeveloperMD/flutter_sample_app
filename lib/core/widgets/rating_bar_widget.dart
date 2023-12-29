import 'package:flutter/material.dart';

class RatingBarWidget extends StatelessWidget {
  final int rating;

  const RatingBarWidget({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.orange,
        );
      }),
    );
  }
}
