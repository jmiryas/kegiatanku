import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/task_model.dart';
import '../providers/timeline_provider.dart';
import '../widgets/cupertino_theme_widget.dart';
import '../widgets/text_form_field_widget.dart';

class AddNewTimelineAndTaskWidget extends StatelessWidget {
  const AddNewTimelineAndTaskWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController taskNameController = TextEditingController();
    TextEditingController taskDescriptionController = TextEditingController();

    String startTime = "";
    String endTime = "";

    DateFormat dateFormat = DateFormat("HH:mm");

    return StatefulBuilder(
      builder: ((context, setState) {
        return AlertDialog(
          title: const Text(
            "Tambah Kegiatan",
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            height: 250.0,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormFieldWidget(
                    controller: taskNameController,
                    hint: "Masukan nama kegiatan",
                    label: "Nama Kegiatan",
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFormFieldWidget(
                    controller: taskDescriptionController,
                    hint: "Masukan deskripsi kegiatan",
                    label: "Deskripsi Kegiatan",
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 200.0,
                                        child: CupertinoThemeWidget(
                                          brightness:
                                              Theme.of(context).brightness,
                                          childWidget: CupertinoDatePicker(
                                            initialDateTime: DateTime.now(),
                                            onDateTimeChanged: (val) {
                                              setState(() {
                                                startTime = val.toString();
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      CupertinoThemeWidget(
                                        brightness:
                                            Theme.of(context).brightness,
                                        childWidget: CupertinoButton(
                                          child: const Text("OK"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                        child: const Text(
                          "Waktu Mulai",
                        ),
                      ),
                      Text(
                        startTime.isEmpty
                            ? "--:--"
                            : dateFormat.format(
                                DateTime.parse(startTime),
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 200.0,
                                        child: CupertinoThemeWidget(
                                          brightness:
                                              Theme.of(context).brightness,
                                          childWidget: CupertinoDatePicker(
                                            initialDateTime: DateTime.now(),
                                            onDateTimeChanged: (val) {
                                              setState(() {
                                                endTime = val.toString();
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      CupertinoThemeWidget(
                                        brightness:
                                            Theme.of(context).brightness,
                                        childWidget: CupertinoButton(
                                          child: const Text("OK"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                        child: const Text(
                          "Waktu Akhir",
                        ),
                      ),
                      Text(
                        endTime.isEmpty
                            ? "--:--"
                            : dateFormat.format(
                                DateTime.parse(endTime),
                              ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Batalkan",
              ),
            ),
            TextButton(
              onPressed: () async {
                if (taskNameController.text.isEmpty) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            "Alert",
                            textAlign: TextAlign.center,
                          ),
                          content:
                              const Text("Nama kegiatan tidak boleh kosong!"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("OK"))
                          ],
                        );
                      });
                } else {
                  TaskModel task = TaskModel(
                    id: DateTime.now().toString(),
                    title: taskNameController.text,
                    description: taskDescriptionController.text.isEmpty
                        ? ""
                        : taskDescriptionController.text,
                    startTime: DateTime.parse(startTime),
                    endTime: DateTime.parse(endTime),
                  );

                  await Provider.of<TimelineProvider>(context, listen: false)
                      .addTimeline(task)
                      .whenComplete(() {
                    startTime = "";
                    endTime = "";
                    taskNameController.clear();
                    taskDescriptionController.clear();

                    ScaffoldMessenger.of(context).hideCurrentSnackBar();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Kegiatan berhasil ditambahkan"),
                        duration: Duration(seconds: 1),
                      ),
                    );

                    Navigator.of(context).pop();
                  });
                }
              },
              child: const Text(
                "OK",
              ),
            )
          ],
        );
      }),
    );
  }
}
