import 'package:daily_quest/daily_quest/presentation/provider/quest_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entity/task.dart';
import 'task_details.dart';

class EditTask extends ConsumerWidget {
  const EditTask({super.key, required this.task, required this.index});
  final Task task;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editedTitle = ref.watch(taskTitleProvider);
    final editedDescription = ref.watch(taskDescriptionProvicer);
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Quest")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TaskDetails(title: task.title, description: task.description),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    ref.read(questListProvider.notifier).editTask(
                        Task(
                            title: editedTitle, description: editedDescription),
                        index);
                    Navigator.pop(context);
                  },
                  child: const Text("Submit")),
            ],
          ),
        ),
      ),
    );
  }
}
