import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task_model.dart';
import '../widgets/column_widget.dart';
import '../providers/timeline_provider.dart';
import '../widgets/toggle_icon_button_widget.dart';

class TaskItemWidget extends StatelessWidget {
  final String timelineId;
  final TaskModel task;

  const TaskItemWidget({
    Key? key,
    required this.timelineId,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormatTask = DateFormat("HH:mm");

    String startTime = dateFormatTask.format(task.startTime);
    String endTime = dateFormatTask.format(task.endTime);

    return ListTile(
      title: Text(
        task.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: task.isComplete
            ? TextStyle(
                fontWeight: FontWeight.w300,
                decoration: TextDecoration.lineThrough,
                decorationThickness: 3.5,
                decorationColor: Theme.of(context).primaryColor,
              )
            : const TextStyle(
                fontWeight: FontWeight.w300,
              ),
      ),
      subtitle: ColumnWidget(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5.0,
            ),
            Text(task.description),
            const SizedBox(
              height: 5.0,
            ),
            Text("$startTime - $endTime"),
            const SizedBox(
              height: 10.0,
            ),
            const SizedBox(
              height: 5.0,
            ),
          ]),
      trailing: IconButton(
        onPressed: () async {
          await Provider.of<TimelineProvider>(context, listen: false)
              .toggleCompleteStatus(timelineId, task.id)
              .whenComplete(() {
            String statusKegiatan = "Kegiatan selesai";

            if (!task.isComplete) {
              statusKegiatan = "Kegiatan selesai";
            } else {
              statusKegiatan = "Kegiatan belum selesai";
            }

            ScaffoldMessenger.of(context).hideCurrentSnackBar();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(statusKegiatan),
                duration: const Duration(seconds: 1),
              ),
            );
          });
        },
        icon: ToggleIconButtonWidget(isComplete: task.isComplete),
      ),
    );
  }
}
