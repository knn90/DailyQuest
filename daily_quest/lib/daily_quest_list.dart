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
        title: Text('title'),
      ),
      body: ListView.builder(
        itemCount: quests.items.length,
        itemBuilder: (context, index) {
          var quest = quests.items[index];
          return ListTile(
              leading: Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.all(Colors.blue),
                value: quest.isDone,
                onChanged: (value) =>
                    context.read<QuestListNotifier>().toogleQuest(index: index),
              ),
              title: Text(quest.title),
              onTap: () {
                Navigator.of(context).push<Quest>(
                  MaterialPageRoute(
                    builder: (context) => DailyQuestDetails(
                      quest: quest,
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
