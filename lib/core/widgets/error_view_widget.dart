import 'package:flutter/cupertino.dart';

class ErrorViewWidget extends StatelessWidget {
  final String error;

  const ErrorViewWidget({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(error),
    );
  }
}
