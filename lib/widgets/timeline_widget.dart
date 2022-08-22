import 'package:flutter/material.dart';

class TimelineWidget extends StatelessWidget {
  final String expansionTileTitle;
  final List<Widget> children;
  final bool initallyExpanded;
  const TimelineWidget({
    Key? key,
    required this.expansionTileTitle,
    required this.children,
    this.initallyExpanded = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        iconColor: Theme.of(context).primaryColor,
        collapsedIconColor: Theme.of(context).primaryColor,
        initiallyExpanded: initallyExpanded,
        title: Text(
          expansionTileTitle,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        children: children,
      ),
    );
  }
}
