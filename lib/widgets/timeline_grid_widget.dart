import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../models/timeline_model.dart';
import '../widgets/timeline_item_widget.dart';
import '../widgets/alert_dialog_remove_timeline_widget.dart';

class TimelineGridWidget extends StatelessWidget {
  final List<TimelineModel> timelines;
  const TimelineGridWidget({
    Key? key,
    required this.timelines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("dd MMMM, yyyy");

    return ListView(
        children: timelines.map((timeline) {
      String timelineTitle = dateFormat.format(DateTime.parse(timeline.id));

      return Card(
        child: ExpansionTile(
          iconColor: Theme.of(context).primaryColor,
          collapsedIconColor: Theme.of(context).primaryColor,
          title: GestureDetector(
            onLongPress: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialogRemoveTimelineWidget(
                        timelineId: timeline.id);
                  });
            },
            child: Text(
              timelineTitle,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          children: [
            TimelineItemWidget(
              timeline: timeline,
            ),
          ],
        ),
      );
    }).toList());
  }
}
