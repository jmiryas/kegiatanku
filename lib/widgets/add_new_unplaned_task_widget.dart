import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/unplaned_task_model.dart';
import '../widgets/text_form_field_widget.dart';
import '../providers/unplaned_task_provider.dart';

class AddNewUnplanedTaskWidget extends StatelessWidget {
  const AddNewUnplanedTaskWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController taskNameController = TextEditingController();
    TextEditingController taskDescriptionController = TextEditingController();

    return AlertDialog(
      title: const Text(
        "Tambah Kegiatan Tanpa Jadwal",
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
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
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Batal"),
        ),
        TextButton(
          onPressed: () async {
            UnplanedTaskModel unplanedTask = UnplanedTaskModel(
              id: DateTime.now().toString(),
              title: taskNameController.text,
              description: taskDescriptionController.text,
            );

            await Provider.of<UnplanedTaskProvider>(context, listen: false)
                .addUnplanedTask(unplanedTask)
                .whenComplete(() {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Kegiatan berhasil ditambahkan"),
                  duration: Duration(seconds: 1),
                ),
              );

              Navigator.of(context).pop();
            });
          },
          child: const Text("OK"),
        ),
      ],
    );
  }
}
