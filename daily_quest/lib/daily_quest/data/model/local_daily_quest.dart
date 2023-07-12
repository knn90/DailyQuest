import 'package:equatable/equatable.dart';

import '../../domain/entity/daily_quest.dart';
import 'local_task.dart';

class LocalDailyQuest extends Equatable {
  final String id;
  final String timestamp;
  final List<LocalTask> tasks;

  const LocalDailyQuest({
    required this.id,
    required this.timestamp,
    required this.tasks,
  });

  DailyQuest toEntity() {
    return DailyQuest(
        id: id,
        timestamp: timestamp,
        tasks: tasks.map((e) => e.toEntity()).toList());
  }

  static LocalDailyQuest fromEntity(DailyQuest entity) {
    return LocalDailyQuest(
      id: entity.id,
      timestamp: entity.timestamp,
      tasks: entity.tasks.map((e) => LocalTask.fromEntity(e)).toList(),
    );
  }

  @override
  List<Object?> get props => [id, timestamp, tasks];
}
