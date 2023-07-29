import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/task.dart';
import '../edit_task/edit_task.dart';
import '../provider/quest_list_provider.dart';

class TaskCell extends ConsumerWidget {
  const TaskCell({super.key, required this.task, required this.index});

  final Task task;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Checkbox(
          value: task.isDone,
          onChanged: (value) {
            ref.read(questListProvider.notifier).toggleTask(index);
          },
        ),
      ),
      title: Text(
        task.title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(
        task.description,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      titleAlignment: ListTileTitleAlignment.top,
      onTap: () {
        Navigator.of(context).push<Task>(
          MaterialPageRoute(
            builder: (context) => EditTask(
              task: task,
              index: index,
            ),
          ),
        );
      },
    );
  }
}
