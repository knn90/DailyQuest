import 'package:daily_quest/daily_quest/presentation/today_quest/task_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/task.dart';
import '../provider/today_quest_provider.dart';

class TaskList extends ConsumerWidget {
  const TaskList({
    super.key,
    required this.tasks,
  });
  final List<Task> tasks;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      child: Container(
        color: theme.colorScheme.onInverseSurface,
        child: ReorderableListView.builder(
          padding: const EdgeInsets.only(bottom: 70),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            var task = tasks[index];
            return Dismissible(
              key: Key("${task.title}_${task.description}"),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                ref.read(todayQuestProvider.notifier).removeTask(index);
              },
              background: Container(
                color: theme.colorScheme.error,
              ),
              child: TaskCell(task: task, index: index),
            );
          },
          onReorder: (oldIndex, newIndex) {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            ref.read(todayQuestProvider.notifier).moveTask(oldIndex, newIndex);
          },
        ),
      ),
    );
  }
}
