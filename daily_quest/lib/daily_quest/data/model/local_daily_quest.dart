import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import '../../domain/entity/daily_quest.dart';
import 'local_task.dart';
part 'local_daily_quest.g.dart';

@HiveType(typeId: 1)
class LocalDailyQuest extends Equatable {
  @HiveField(0)
  final String timestamp;
  @HiveField(1)
  final List<LocalTask> tasks;

  const LocalDailyQuest({
    required this.timestamp,
    required this.tasks,
  });

  DailyQuest toEntity() {
    return DailyQuest(
        timestamp: timestamp, tasks: tasks.map((e) => e.toEntity()).toList());
  }

  static LocalDailyQuest fromEntity(DailyQuest entity) {
    return LocalDailyQuest(
      timestamp: entity.timestamp,
      tasks: entity.tasks.map((e) => LocalTask.fromEntity(e)).toList(),
    );
  }

  @override
  List<Object?> get props => [timestamp, tasks];
}
