import 'package:flutter/material.dart';

class EmptyMessageWidget extends StatelessWidget {
  final String message;
  const EmptyMessageWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(message),
      ),
    );
  }
}
