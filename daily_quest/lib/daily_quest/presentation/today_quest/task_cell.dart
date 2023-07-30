import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/task.dart';
import '../edit_task/edit_task.dart';
import '../provider/today_quest_provider.dart';

class TaskCell extends ConsumerWidget {
  const TaskCell({super.key, required this.task, required this.index});

  final Task task;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Column(
      children: [
        ListTile(
          leading: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Checkbox(
              value: task.isDone,
              onChanged: (value) {
                ref.read(todayQuestProvider.notifier).toggleTask(index);
              },
            ),
          ),
          title: Text(
            task.title,
            style: theme.textTheme.titleMedium,
          ),
          subtitle: Text(
            task.description,
            style: theme.textTheme.bodySmall,
          ),
          titleAlignment: ListTileTitleAlignment.top,
          contentPadding: const EdgeInsets.only(left: 16, right: 40),
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
        ),
        Container(
          height: 1,
          color: theme.colorScheme.background,
        )
      ],
    );
  }
}
