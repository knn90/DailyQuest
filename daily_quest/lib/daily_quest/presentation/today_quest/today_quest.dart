import 'package:daily_quest/daily_quest/presentation/provider/today_quest_provider.dart';
import 'package:daily_quest/daily_quest/presentation/today_quest/task_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../l10n/generated/l10n.dart';
import 'add_task_button.dart';

class TodayQuestScreen extends ConsumerWidget {
  const TodayQuestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyQuest = ref.watch(todayQuestProvider);
    final strings = Strings.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.quest),
      ),
      floatingActionButton: const AddTaskButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: dailyQuest.when(
        data: (data) {
          final totalTasks = data.tasks.length;
          final doneTasks = data.tasks.where((task) => task.isDone).length;
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: theme.colorScheme.background),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(strings.todayChecklists,
                        textAlign: TextAlign.start,
                        style: theme.textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold)
                            .copyWith(letterSpacing: -1.5)),
                    Text(strings.doneOutOfTaskCount(doneTasks, totalTasks),
                        textAlign: TextAlign.start,
                        style: theme.textTheme.headlineSmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: TaskList(tasks: data.tasks),
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) {
          return Text('Error: $error');
        },
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}
