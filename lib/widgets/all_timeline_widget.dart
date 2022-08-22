import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/timeline_provider.dart';
import '../widgets/empty_screen_widget.dart';
import '../widgets/timeline_grid_widget.dart';

class AllTimelineWidget extends StatelessWidget {
  const AllTimelineWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Consumer<TimelineProvider>(
        builder: ((context, value, child) {
          if (value.timelines.isNotEmpty) {
            return TimelineGridWidget(timelines: value.timelines);
          } else {
            return const EmptyScreenWidget(
              title: "Wah, timeline kamu masih kosong nih!",
              image: "timeline.png",
            );
          }
        }),
      ),
    );
  }
}
