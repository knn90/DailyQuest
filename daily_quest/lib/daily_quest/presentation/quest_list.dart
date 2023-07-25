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
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: data.tasks.length,
                  itemBuilder: (context, index) {
                    var task = data.tasks[index];
                    return Dismissible(
                      key: Key("${task.title}_${task.description}"),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) => {},
                      background: Container(color: Colors.red),
                      child: ListTile(
                          leading: Checkbox(
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.all(Colors.blue),
                            value: task.isDone,
                            onChanged: (value) {
                              ref
                                  .read(questListProvider.notifier)
                                  .toggleTask(index);
                            },
                          ),
                          title: Text(task.title),
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
                    );
                  },
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
