class Quest {
  String title;
  String? description;
  bool isDone = false;

  Quest({required this.title, this.description});

  set setTitle(String title) {
    this.title = title;
  }

  set setDescription(String description) {
    this.description = description;
  }
}
