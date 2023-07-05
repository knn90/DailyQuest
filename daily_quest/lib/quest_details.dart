import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'quest.dart';

class DailyQuestDetails extends StatefulWidget {
  const DailyQuestDetails({super.key, required this.quest});
  final Quest quest;

  @override
  State<DailyQuestDetails> createState() => _DailyQuestDetailsState();
}

class _DailyQuestDetailsState extends State<DailyQuestDetails> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.quest.title);
    _descriptionController =
        TextEditingController(text: widget.quest.description);
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Quest Details")),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  onChanged: (value) => widget.quest.title = value,
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: const InputDecoration(
                    hintText: "Description",
                  ),
                  controller: _descriptionController,
                  onChanged: (value) => widget.quest.description = value,
                  maxLines: 5,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      context.read<QuestListNotifier>().update(widget.quest);
                      Navigator.pop(context);
                    },
                    child: const Text("Submit")),
              ],
            ),
          ),
        ));
  }
}
