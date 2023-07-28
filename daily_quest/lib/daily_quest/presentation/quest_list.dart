import 'package:daily_quest/daily_quest/presentation/provider/quest_list_provider.dart';
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
          return Stack(children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Today checklists",
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.separated(
                      itemCount: data.tasks.length,
                      itemBuilder: (context, index) {
                        var task = data.tasks[index];
                        return ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          child: Dismissible(
                            key: Key("${task.title}_${task.description}"),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              ref
                                  .read(questListProvider.notifier)
                                  .removeTask(index);
                            },
                            background: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.error,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16)))),
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onInverseSurface),
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
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  subtitle: Text(
                                    task.description,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
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
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Positioned.fill(
              bottom: 40,
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => const AddTask(),
                        ),
                      );
                    },
                    child: const Icon(Icons.add_circle_sharp),
                  )),
            )
          ]);
        },
        error: (error, stackTrace) {
          return Text('Error: $error');
        },
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}
