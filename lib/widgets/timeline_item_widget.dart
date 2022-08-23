import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

import '../models/task_model.dart';
import '../models/timeline_model.dart';
import '../widgets/task_item_widget.dart';
import '../widgets/alert_dialog_remove_task_widget.dart';

class TimelineItemWidget extends StatelessWidget {
  final TimelineModel timeline;

  const TimelineItemWidget({
    Key? key,
    required this.timeline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
      child: FixedTimeline.tileBuilder(
        theme: TimelineTheme.of(context).copyWith(
          nodePosition: 0,
          connectorTheme: TimelineTheme.of(context).connectorTheme.copyWith(
                thickness: 1.5,
                color: Theme.of(context).primaryColor,
              ),
          indicatorTheme: TimelineTheme.of(context).indicatorTheme.copyWith(
                size: 10.0,
                position: 0.13,
                color: Theme.of(context).primaryColor,
              ),
        ),
        builder: TimelineTileBuilder.connectedFromStyle(
          contentsAlign: ContentsAlign.basic,
          contentsBuilder: (context, index) {
            TaskModel task = timeline.timelines[index];

            return GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialogRemoveTaskWidget(
                          timelineId: timeline.id, taskId: task.id);
                    });
              },
              child: TaskItemWidget(timelineId: timeline.id, task: task),
            );
          },
          connectorStyleBuilder: (context, index) => ConnectorStyle.solidLine,
          indicatorStyleBuilder: (context, index) => IndicatorStyle.dot,
          itemCount: timeline.timelines.length,
        ),
      ),
    );
  }
}
