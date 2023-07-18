import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/entity/quest.dart';
import 'add_quest.dart';
import 'edit_quest.dart';
import 'quest_list_notifier.dart';

class DailyQuestList extends StatelessWidget {
  const DailyQuestList({super.key});

  @override
  Widget build(BuildContext context) {
    final quests = context.watch<QuestListViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quests'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: quests.items.length,
              itemBuilder: (context, index) {
                var quest = quests.items[index];
                return Dismissible(
                  key: Key("${quest.title}_${quest.description}"),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) =>
                      {context.read<QuestListViewModel>().remove(quest: quest)},
                  background: Container(color: Colors.red),
                  child: ListTile(
                      leading: Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.all(Colors.blue),
                        value: quest.isDone,
                        onChanged: (value) => context
                            .read<QuestListViewModel>()
                            .toogleQuest(index: index),
                      ),
                      title: Text(quest.title),
                      onTap: () {
                        Navigator.of(context).push<Quest>(
                          MaterialPageRoute(
                            builder: (context) => EditQuest(
                              quest: quest,
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
                  builder: (context) => AddQuest(
                    quest: Quest(title: ""),
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
