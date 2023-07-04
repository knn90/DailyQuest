import 'package:flutter/material.dart';
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
    _descriptionController = TextEditingController();
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
      appBar: AppBar(
        title: const Text("Quest Details")
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
          ),
          TextField(
            decoration: const InputDecoration(
              hintText: "Description",
            ),
            controller: _descriptionController,
            maxLines: 5,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                widget.quest.title = _titleController.text;
              });
            },
            child: const Text("Submit")
          ),
        ],
      ),
    );
  }
}