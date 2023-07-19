import 'package:flutter/material.dart';

import '../domain/entity/task.dart';
import 'add_quest.dart';
import 'edit_quest.dart';

class DailyQuestList extends StatelessWidget {
  const DailyQuestList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Task> tasks = [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quests'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                var task = tasks[index];
                return Dismissible(
                  key: Key("${task.title}_${task.description}"),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) => {},
                  background: Container(color: Colors.red),
                  child: ListTile(
                      leading: Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.all(Colors.blue),
                        value: false,
                        onChanged: (value) {},
                      ),
                      title: Text(task.title),
                      onTap: () {
                        Navigator.of(context).push<Task>(
                          MaterialPageRoute(
                            builder: (context) => EditQuest(
                              quest: task,
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
                  builder: (context) => const AddQuest(
                    quest: Task(title: '', description: ''),
                  ),
                ),
              )
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
