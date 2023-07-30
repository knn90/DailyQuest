import 'package:daily_quest/daily_quest/presentation/provider/today_quest_provider.dart';
import 'package:daily_quest/daily_quest/presentation/today_quest/task_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'add_task_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TodayQuest extends ConsumerWidget {
  const TodayQuest({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyQuest = ref.watch(todayQuestProvider);
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).quest),
      ),
      floatingActionButton: const AddTaskButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: dailyQuest.when(
        data: (data) {
          final totalTasks = data.tasks.length;
          final doneTasks = data.tasks.where((task) => task.isDone).length;
          return Container(
            padding: const EdgeInsets.all(16),
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.background),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(localizations.todayChecklists,
                        textAlign: TextAlign.start,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold)
                            .copyWith(letterSpacing: -1.5)),
                    Text(
                        localizations.doneOutOfTaskCount(doneTasks, totalTasks),
                        textAlign: TextAlign.start,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
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
