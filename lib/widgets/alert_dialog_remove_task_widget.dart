import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/timeline_provider.dart';

class AlertDialogRemoveTaskWidget extends StatelessWidget {
  final String timelineId;
  final String taskId;
  const AlertDialogRemoveTaskWidget({
    Key? key,
    required this.timelineId,
    required this.taskId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Hapus Kegiatan?",
        textAlign: TextAlign.center,
      ),
      content: const Text("Kamu yakin ingin menghapus kegiatan ini?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Tidak"),
        ),
        TextButton(
          onPressed: () async {
            await Provider.of<TimelineProvider>(context, listen: false)
                .removeTaskFromTimelineById(timelineId, taskId)
                .whenComplete(() {
              Navigator.of(context).pop();

              ScaffoldMessenger.of(context).hideCurrentSnackBar();

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
  }
}
