import 'package:flutter/material.dart';

class ToggleIconButtonWidget extends StatelessWidget {
  final bool isComplete;
  const ToggleIconButtonWidget({
    Key? key,
    required this.isComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !isComplete
        ? const Icon(
            Icons.toggle_off,
            size: 35.0,
          )
        : Icon(
            Icons.toggle_on,
            size: 35.0,
            color: Theme.of(context).primaryColor,
          );
  }
}
