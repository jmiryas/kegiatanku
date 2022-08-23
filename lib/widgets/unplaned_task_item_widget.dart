import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/unplaned_task_model.dart';
import '../providers/unplaned_task_provider.dart';

class UnplanedTaskItemWidget extends StatelessWidget {
  final UnplanedTaskModel task;

  const UnplanedTaskItemWidget({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(task.title),
        subtitle: Text(task.description),
        trailing: IconButton(
            onPressed: () async {
              await Provider.of<UnplanedTaskProvider>(context, listen: false)
                  .removeUnplanedTask(task)
                  .whenComplete(() {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Kegiatan berhasil ditambahkan"),
                    duration: Duration(seconds: 1),
                  ),
                );
              });
            },
            icon: Icon(
              Icons.check_circle_rounded,
              color: Theme.of(context).primaryColor,
            )),
      ),
    );
  }
}
