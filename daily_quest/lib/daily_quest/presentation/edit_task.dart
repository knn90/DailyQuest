import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entity/task.dart';
import 'task_details.dart';

class EditTask extends ConsumerWidget {
  const EditTask({super.key, required this.quest});
  final Task quest;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(taskTitleProvider);
    final description = ref.watch(taskDescriptionProvicer);
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Quest")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TaskDetails(title: title, description: description),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
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
