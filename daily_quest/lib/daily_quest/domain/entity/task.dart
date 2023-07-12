import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String title;
  final String description;
  final bool isDone = false;

  const Task({
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [title, description, isDone];
}
