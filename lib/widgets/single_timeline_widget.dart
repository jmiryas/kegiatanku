import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/timeline_model.dart';
import '../widgets/timeline_widget.dart';
import '../providers/timeline_provider.dart';
import '../widgets/empty_screen_widget.dart';
import '../widgets/empty_message_widget.dart';
import '../widgets/timeline_item_widget.dart';
import '../widgets/alert_dialog_remove_timeline_widget.dart';

class SingleTimelineWidget extends StatelessWidget {
  const SingleTimelineWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("dd MMMM, yyyy");

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Consumer<TimelineProvider>(builder: ((context, value, child) {
        if (value.isCurrentTimelineExist()) {
          TimelineModel currentTimeline = value.getCurrentTimeline();

          String timelineTitle =
              dateFormat.format(DateTime.parse(currentTimeline.id));

          return GestureDetector(
            onLongPress: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialogRemoveTimelineWidget(
                        timelineId: currentTimeline.id);
                  });
            },
            child: SingleChildScrollView(
              child: TimelineWidget(
                expansionTileTitle: timelineTitle,
                initallyExpanded: true,
                children: currentTimeline.timelines.isNotEmpty
                    ? [
                        TimelineItemWidget(
                          timeline: currentTimeline,
                        )
                      ]
                    : [
                        const EmptyMessageWidget(
                            message:
                                "Wah, kegiatan kamu hari ini belum ada nih!")
                      ],
              ),
            ),
          );
        } else {
          return const EmptyScreenWidget(
            title: "Wah, kegiatan kamu hari ini masih kosong nih!",
            image: "icon.png",
          );
        }
      })),
    );
  }
}
