import 'package:flutter/material.dart';

class EmptyScreenWidget extends StatelessWidget {
  final String title;
  final String image;
  const EmptyScreenWidget({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 18.0,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          SizedBox(
            width: 100.0,
            height: 100.0,
            child: Image.asset("assets/images/$image"),
          ),
        ],
      ),
    );
  }
}
