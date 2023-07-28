import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final taskTitleProvider =
    StateProvider.autoDispose.family<String, String>((ref, title) => title);
final taskDescriptionProvicer = StateProvider.autoDispose
    .family<String, String>((ref, description) => description);

class TaskDetails extends ConsumerStatefulWidget {
  const TaskDetails(
      {super.key, required this.title, required this.description});
  final String title;
  final String description;

  @override
  TaskDetailsState createState() => TaskDetailsState();
}

class TaskDetailsState extends ConsumerState<TaskDetails> {
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
    StateController<String> title =
        ref.watch(taskTitleProvider(widget.title).notifier);
    StateController<String> description =
        ref.watch(taskDescriptionProvicer(widget.description).notifier);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: "Title",
              filled: false,
            ),
            controller: _titleController,
            autofocus: true,
            onChanged: (value) {
              title.state = value;
            },
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: const InputDecoration(
              hintText: "Description",
              filled: false,
            ),
            controller: _descriptionController,
            onChanged: (value) => description.state = value,
            maxLines: 14,
            minLines: 1,
          ),
        ],
      ),
    );
  }
}
