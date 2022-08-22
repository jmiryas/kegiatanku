import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/timeline_provider.dart';

class AlertDialogRemoveTimelineWidget extends StatelessWidget {
  final String timelineId;

  const AlertDialogRemoveTimelineWidget({
    Key? key,
    required this.timelineId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Hapus Timeline?",
        textAlign: TextAlign.center,
      ),
      content: const Text("Kamu yakin ingin menghapus timeline ini?"),
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
                .removeTimelineById(timelineId)
                .whenComplete(() {
              Navigator.of(context).pop();

              ScaffoldMessenger.of(context).hideCurrentSnackBar();

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Timeline berhasil dihapus"),
                  duration: Duration(seconds: 1),
                ),
              );
            });
          },
          child: const Text("Ya"),
        )
      ],
    );
  }
}
