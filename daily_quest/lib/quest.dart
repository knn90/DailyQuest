import 'dart:collection';

import 'package:flutter/material.dart';

class Quest extends ChangeNotifier {
  String title;
  String? description;

  Quest({required this.title, this.description});

  set setTitle(String title) {
    this.title = title;
    notifyListeners();
  }

  set setDescription(String description) {
    this.description = description;
    notifyListeners();
  }
}

class QuestList extends ChangeNotifier {
  final List<Quest> _items = [];
  UnmodifiableListView<Quest> get items => UnmodifiableListView(_items);
  
  void add(Quest item) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}