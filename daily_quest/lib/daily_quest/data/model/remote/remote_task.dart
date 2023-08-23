import 'package:equatable/equatable.dart';

class RemoteTask extends Equatable {
  final String title;
  final String description;
  final bool isDone;

  const RemoteTask({
    required this.title,
    required this.description,
    this.isDone = false,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['is_done'] = isDone;
    return data;
  }

  static RemoteTask fromJson(Map<String, dynamic> json) {
    return RemoteTask(
      title: json['title'],
      description: json['description'],
      isDone: json['is_done'],
    );
  }

  @override
  List<Object?> get props => [title, description, isDone];
}
