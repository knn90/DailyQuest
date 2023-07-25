import 'package:daily_quest/daily_quest/presentation/provider/quest_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/entity/task.dart';
import 'task_details.dart';

class AddTask extends ConsumerWidget {
  const AddTask({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(taskTitleProvider(''));
    final description = ref.watch(taskDescriptionProvicer(''));
    return Scaffold(
      appBar: AppBar(title: const Text("Add Task")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TaskDetails(
                title: title,
                description: description,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    ref.read(questListProvider.notifier).addTask(
                          Task(title: title, description: description),
                        );
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
