import 'package:daily_quest/daily_quest/data/model/remote/remote_task.dart';
import 'package:equatable/equatable.dart';

class RemoteDailyQuest extends Equatable {
  final String timestamp;
  final List<RemoteTask> tasks;

  const RemoteDailyQuest({
    required this.timestamp,
    required this.tasks,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timestamp'] = timestamp;
    data['tasks'] = tasks.map((e) => e.toJson()).toList();
    return data;
  }

  static RemoteDailyQuest fromJson(Map<String, dynamic> json) {
    final remoteTasksJson = json['tasks'] as List<Map<String, dynamic>>;
    final remoteTasks =
        remoteTasksJson.map((e) => RemoteTask.fromJson(e)).toList();
    return RemoteDailyQuest(
      timestamp: json['timestamp'],
      tasks: remoteTasks,
    );
  }

  @override
  List<Object?> get props => [timestamp, tasks];
}
