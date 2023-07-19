import 'package:equatable/equatable.dart';
import '../../domain/entity/task.dart';
import 'package:hive/hive.dart';
part 'local_task.g.dart';

@HiveType(typeId: 2)
class LocalTask extends Equatable {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final bool isDone;

  const LocalTask({
    required this.title,
    required this.description,
    this.isDone = false,
  });

  Task toEntity() {
    return Task(
      title: title,
      description: description,
    );
  }

  static LocalTask fromEntity(Task entity) {
    return LocalTask(
      title: entity.title,
      description: entity.description,
      isDone: entity.isDone,
    );
  }

  @override
  List<Object?> get props => [title, description, isDone];
}
