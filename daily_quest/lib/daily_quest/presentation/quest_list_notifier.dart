import 'dart:collection';

import 'package:daily_quest/daily_quest/domain/entity/quest.dart';
import 'package:flutter/material.dart';

class QuestListNotifier extends ChangeNotifier {
  final List<Quest> _items = [
    Quest(title: "Quest 1"),
  ];
  UnmodifiableListView<Quest> get items => UnmodifiableListView(_items);

  void add(Quest item) {
    _items.add(item);
    notifyListeners();
  }

  update(Quest? quest) {
    if (quest == null) return;
    final updatedIndex = _items.indexOf(quest);
    _items[updatedIndex] = quest;
    notifyListeners();
  }

  toogleQuest({required int index}) {
    _items[index].isDone = !_items[index].isDone;
    notifyListeners();
  }

  remove({required Quest quest}) {
    _items.remove(quest);
  }
}
