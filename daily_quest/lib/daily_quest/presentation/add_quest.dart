import 'package:daily_quest/daily_quest/domain/entity/task.dart';
import 'package:flutter/material.dart';
import 'quest_details.dart';

class AddQuest extends StatelessWidget {
  const AddQuest({super.key, required this.quest});
  final Task quest;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Quest")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              QuestDetails(quest: quest),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
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
