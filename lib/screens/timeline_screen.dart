import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/all_timeline_widget.dart';
import '../enums/selected_timeline_enum.dart';
import '../widgets/single_timeline_widget.dart';
import '../providers/selected_timeline_provider.dart';
import '../widgets/add_new_timeline_and_task_widget.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget getSelectedWidget(SelectedTimelineEnum timeline) {
      switch (timeline) {
        case SelectedTimelineEnum.semua:
          return const AllTimelineWidget();
        case SelectedTimelineEnum.harian:
          return const SingleTimelineWidget();
        default:
          return const AllTimelineWidget();
      }
    }

    String getSelectedWidgetTitle(SelectedTimelineEnum timeline) {
      switch (timeline) {
        case SelectedTimelineEnum.semua:
          return "Semua Timeline";
        case SelectedTimelineEnum.harian:
          return "Timeline Hari Ini";
        default:
          return "Semua Timeline";
      }
    }

    SelectedTimelineProvider selectedTimelineProvider =
        Provider.of<SelectedTimelineProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              getSelectedWidgetTitle(selectedTimelineProvider.selectedTimeline),
            ),
            actions: [
              PopupMenuButton<SelectedTimelineEnum>(
                onSelected: (SelectedTimelineEnum timeline) {
                  Provider.of<SelectedTimelineProvider>(context, listen: false)
                      .setSelectedTimeline(timeline);
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: SelectedTimelineEnum.semua,
                    child: Text("Semua"),
                  ),
                  const PopupMenuItem(
                    value: SelectedTimelineEnum.harian,
                    child: Text("Harian"),
                  )
                ],
              )
            ]),
        body: getSelectedWidget(
            Provider.of<SelectedTimelineProvider>(context).selectedTimeline),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const AddNewTimelineAndTaskWidget();
                });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
