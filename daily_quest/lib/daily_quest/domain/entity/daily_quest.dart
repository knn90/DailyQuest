import 'package:equatable/equatable.dart';

import 'task.dart';

class DailyQuest extends Equatable {
  final String timestamp;
  final List<Task> tasks;

  const DailyQuest({
    required this.timestamp,
    required this.tasks,
  });

  @override
  List<Object?> get props => [timestamp, tasks];
}
