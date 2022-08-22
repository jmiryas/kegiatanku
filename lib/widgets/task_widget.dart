import 'package:flutter/material.dart';

import '../widgets/column_widget.dart';

class TaskWidget extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  final Widget trailing;
  const TaskWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ColumnWidget(children: [
        CircleAvatar(
          radius: 6.0,
          backgroundColor: Theme.of(context).primaryColor,
        )
      ]),
      title: title,
      subtitle: subtitle,
      trailing: trailing,
    );
  }
}
