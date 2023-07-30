import 'package:daily_quest/daily_quest/presentation/provider/today_quest_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../l10n/strings.dart';
import '../../domain/entity/task.dart';
import '../task_details/task_details.dart';

class AddTask extends ConsumerWidget {
  const AddTask({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(taskTitleProvider(''));
    final description = ref.watch(taskDescriptionProvicer(''));
    final strings = Strings.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(strings.addTask)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const TaskDetails(
                title: '',
                description: '',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: _onSubmitPressed(context, ref, title, description),
                  child: Text(strings.submit)),
            ],
          ),
        ),
      ),
    );
  }

  _onSubmitPressed(
    BuildContext context,
    WidgetRef ref,
    String title,
    String description,
  ) {
    if (title.isEmpty) {
      return null;
    } else {
      return () {
        ref.read(todayQuestProvider.notifier).addTask(
              Task(title: title, description: description),
            );
        Navigator.pop(context);
      };
    }
  }
}
