import 'package:daily_quest/daily_quest/presentation/provider/quest_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/entity/task.dart';
import 'quest_details.dart';

final taskProvider =
    Provider<Task>((ref) => const Task(title: '', description: ''));

class AddTask extends ConsumerWidget {
  const AddTask({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(taskProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Add Task")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              QuestDetails(
                title: task.title,
                description: task.description,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    ref.read(questListProvider.notifier).addTask(task);
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
