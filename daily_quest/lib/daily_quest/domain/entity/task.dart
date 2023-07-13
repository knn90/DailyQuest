import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String title;
  final String description;
  final bool isDone;

  const Task({
    required this.title,
    required this.description,
    this.isDone = false,
  });

  @override
  List<Object?> get props => [title, description, isDone];
}
