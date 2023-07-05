import 'package:daily_quest/edit_quest.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'quest_details.dart';
import 'quest.dart';

class DailyQuestList extends StatelessWidget {
  const DailyQuestList({super.key});

  @override
  Widget build(BuildContext context) {
    final quests = context.watch<QuestListNotifier>();
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
                return ListTile(
                    leading: Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.all(Colors.blue),
                      value: quest.isDone,
                      onChanged: (value) => context
                          .read<QuestListNotifier>()
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
                    });
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
                  builder: (context) => DailyQuestDetails(
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
