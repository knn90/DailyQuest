import 'package:daily_quest/quest_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'quest.dart';

class EditQuest extends StatelessWidget {
  const EditQuest({super.key, required this.quest});
  final Quest quest;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Quest")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              DailyQuestDetails(quest: quest),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    context.read<QuestListNotifier>().update(quest);
                    Navigator.pop(context);
                  },
                  child: const Text("Submit")),
            ],
          ),
        ),
      ),
    );
  }
}
