import 'dart:collection';

import 'package:flutter/material.dart';

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

class QuestListNotifier extends ChangeNotifier {
  final List<Quest> _items = [
    Quest(title: "Quest 1"),
  ];
  UnmodifiableListView<Quest> get items => UnmodifiableListView(_items);

  void add(Quest item) {
    _items.add(item);
    notifyListeners();
  }

  void update(Quest? quest) {
    if (quest == null) return;
    final updatedIndex = _items.indexOf(quest);
    _items[updatedIndex] = quest;
    notifyListeners();
  }

  toogleQuest({required int index}) {
    _items[index].isDone = !_items[index].isDone;
    notifyListeners();
  }
}
