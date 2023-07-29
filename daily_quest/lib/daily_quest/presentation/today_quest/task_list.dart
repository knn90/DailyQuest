import 'package:daily_quest/daily_quest/presentation/today_quest/task_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/task.dart';
import '../provider/quest_list_provider.dart';

class TaskList extends ConsumerWidget {
  const TaskList({
    super.key,
    required this.tasks,
  });
  final List<Task> tasks;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        var task = tasks[index];
        return ClipRRect(
          key: Key("${task.title}_${task.description}"),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: Dismissible(
            key: Key("${task.title}_${task.description}"),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              ref.read(questListProvider.notifier).removeTask(index);
            },
            background: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.error,
                borderRadius: const BorderRadius.all(Radius.circular(16)),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onInverseSurface),
              child: TaskCell(task: task, index: index),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          height: 10,
          indent: 0,
          endIndent: 0,
          color: Colors.transparent,
        );
      },
    );
  }
}
