import 'package:flutter/material.dart';
import 'quest.dart';

class QuestDetails extends StatefulWidget {
  const QuestDetails({super.key, required this.quest});
  final Quest quest;

  @override
  State<QuestDetails> createState() => _QuestDetailsState();
}

class _QuestDetailsState extends State<QuestDetails> {
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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: "Title",
            ),
            controller: _titleController,
            onChanged: (value) => widget.quest.title = value,
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: const InputDecoration(
              hintText: "Description",
            ),
            controller: _descriptionController,
            onChanged: (value) => widget.quest.description = value,
            maxLines: 5,
          ),
        ],
      ),
    );
  }
}
