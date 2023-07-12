import 'package:equatable/equatable.dart';

import '../../domain/entity/task.dart';

class LocalTask extends Equatable {
  final String title;
  final String description;
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
