import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/empty_screen_widget.dart';
import '../providers/unplaned_task_provider.dart';
import '../widgets/unplaned_task_item_widget.dart';
import '../widgets/add_new_unplaned_task_widget.dart';

class UnplanedScreen extends StatelessWidget {
  const UnplanedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Kegiatan Tanpa Jadwal"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child:
            Consumer<UnplanedTaskProvider>(builder: ((context, value, child) {
          if (value.unplanedTasks.isNotEmpty) {
            return ListView(
                children: value.unplanedTasks.map((task) {
              return UnplanedTaskItemWidget(task: task);
            }).toList());
          } else {
            return const EmptyScreenWidget(
              title: "Wah, kegiatan tanpa jadwal kamu masih kosong nih!",
              image: "icon.png",
            );
          }
        })),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AddNewUnplanedTaskWidget();
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
