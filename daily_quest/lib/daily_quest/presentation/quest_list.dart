import 'package:daily_quest/daily_quest/presentation/provider/quest_list_provider.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entity/task.dart';
import 'add_task.dart';
import 'edit_task.dart';

class DailyQuestList extends ConsumerWidget {
  const DailyQuestList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyQuest = ref.watch(questListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quests'),
      ),
      body: dailyQuest.when(
        data: (data) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration:
                BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      color: Theme.of(context)
                          .appBarTheme
                          .backgroundColor, // Your desired background color
                      boxShadow: [
                        BoxShadow(
                            color:
                                Theme.of(context).shadowColor.withOpacity(0.2),
                            blurRadius: 8),
                      ],
                    ),
                    child: ClipRect(
                      child: ListView.separated(
                        itemCount: data.tasks.length,
                        itemBuilder: (context, index) {
                          var task = data.tasks[index];
                          return Dismissible(
                            key: Key("${task.title}_${task.description}"),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              ref
                                  .read(questListProvider.notifier)
                                  .removeTask(index);
                            },
                            background: ClipRect(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.error,
                                    borderRadius: index == 0
                                        ? const BorderRadius.only(
                                            topRight: Radius.circular(16))
                                        : null),
                              ),
                            ),
                            child: ListTileTheme(
                              child: ListTile(
                                  leading: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Checkbox(
                                      value: task.isDone,
                                      onChanged: (value) {
                                        ref
                                            .read(questListProvider.notifier)
                                            .toggleTask(index);
                                      },
                                    ),
                                  ),
                                  title: Text(
                                    task.title,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  subtitle: Text(
                                    task.description,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary),
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
                                  }),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            height: 1,
                            indent: 0,
                            endIndent: 0,
                            color: Theme.of(context).dividerColor,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20)),
                  child: const Text("+"),
                  onPressed: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => const AddTask(),
                      ),
                    )
                  },
                ),
                const SizedBox(height: 30),
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
