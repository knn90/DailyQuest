import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final taskTitleProvider = StateProvider.autoDispose<String>((ref) => '');
final taskDescriptionProvicer = StateProvider.autoDispose((ref) => '');

class QuestDetails extends ConsumerStatefulWidget {
  const QuestDetails(
      {super.key, required this.title, required this.description});
  final String title;
  final String description;

  @override
  QuestDetailsState createState() => QuestDetailsState();
}

class QuestDetailsState extends ConsumerState<QuestDetails> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _descriptionController = TextEditingController(text: widget.description);
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StateController<String> title = ref.watch(taskTitleProvider.notifier);
    StateController<String> description =
        ref.watch(taskDescriptionProvicer.notifier);
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
            onChanged: (value) => title.state = value,
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: const InputDecoration(
              hintText: "Description",
            ),
            controller: _descriptionController,
            onChanged: (value) => description.state = value,
            maxLines: 5,
          ),
        ],
      ),
    );
  }
}
