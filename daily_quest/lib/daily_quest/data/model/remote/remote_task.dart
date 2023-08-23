class RemoteTask {
  final String title;
  final String description;
  final bool isDone;

  RemoteTask({
    required this.title,
    required this.description,
    this.isDone = false,
  });
}
