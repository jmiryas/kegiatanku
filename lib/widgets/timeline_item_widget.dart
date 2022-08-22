import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';

import '../models/task_model.dart';
import '../models/timeline_model.dart';
import '../widgets/column_widget.dart';
import '../providers/timeline_provider.dart';

class TimelineItemWidget extends StatelessWidget {
  final TimelineModel timeline;

  const TimelineItemWidget({
    Key? key,
    required this.timeline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormatTask = DateFormat("HH:mm");

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
                position: 0.15,
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
                      return AlertDialog(
                        title: const Text(
                          "Hapus Kegiatan?",
                          textAlign: TextAlign.center,
                        ),
                        content: const Text(
                            "Kamu yakin ingin menghapus kegiatan ini?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Tidak"),
                          ),
                          TextButton(
                            onPressed: () async {
                              await Provider.of<TimelineProvider>(context,
                                      listen: false)
                                  .removeTaskFromTimelineById(
                                      timeline.id, task.id)
                                  .whenComplete(() {
                                Navigator.of(context).pop();

                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Kegiatan berhasil dihapus"),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              });
                            },
                            child: const Text("Ya"),
                          ),
                        ],
                      );
                    });
              },
              child: ListTile(
                title: Text(
                  task.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: task.isComplete
                      ? TextStyle(
                          fontWeight: FontWeight.w100,
                          decoration: TextDecoration.lineThrough,
                          decorationThickness: 3.5,
                          decorationColor: Theme.of(context).primaryColor,
                        )
                      : const TextStyle(
                          fontWeight: FontWeight.w100,
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
                      Text(
                          "${dateFormatTask.format(task.startTime)} - ${dateFormatTask.format(task.endTime)}"),
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
                        .toggleCompleteStatus(timeline.id, task.id)
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
                  icon: !task.isComplete
                      ? const Icon(
                          Icons.toggle_off,
                          size: 35.0,
                        )
                      : Icon(
                          Icons.toggle_on,
                          size: 35.0,
                          color: Theme.of(context).primaryColor,
                        ),
                ),
              ),
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
