import 'package:flutter/material.dart';

class ProductActionButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const ProductActionButtonWidget(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: onPressed,
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.yellow),
        ),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
