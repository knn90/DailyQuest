import 'package:daily_quest/daily_quest/data/model/local/local_daily_quest.dart';
import 'package:daily_quest/daily_quest/domain/exception/exceptions.dart';
import 'package:hive/hive.dart';

import '../../model/local/local_task.dart';
import 'daily_quest_local_datasource.dart';

class HiveLocalDataSource implements DailyQuestLocalDataSource {
  final Box box;

  HiveLocalDataSource({required this.box});
  @override
  LocalDailyQuest getLast() {
    if (box.isEmpty) {
      throw DailyQuestNotFound();
    }
    return box.getAt(box.length - 1);
  }

  @override
  Future<void> insert({required LocalDailyQuest quest}) async {
    await box.add(quest);
    return;
  }

  @override
  Future<void> update({required LocalDailyQuest quest}) {
    if (box.isEmpty) {
      throw DailyQuestNotFound();
    }
    return box.putAt(box.length - 1, quest);
  }

  @override
  Future<LocalDailyQuest> addTask({required LocalTask task}) async {
    if (box.isEmpty) {
      throw DailyQuestNotFound();
    }
    final lastQuestIndex = box.length - 1;
    LocalDailyQuest quest = box.getAt(lastQuestIndex);
    final updatedQuest = quest.addTask(task);
    await box.putAt(lastQuestIndex, updatedQuest);
    return updatedQuest;
  }

  @override
  Future<LocalDailyQuest> editTask(
      {required LocalTask task, required int index}) async {
    if (box.isEmpty) {
      throw DailyQuestNotFound();
    }

    final lastQuestIndex = box.length - 1;
    LocalDailyQuest quest = box.getAt(lastQuestIndex);
    final updatedQuest = quest.editTask(task, index);
    await box.putAt(lastQuestIndex, updatedQuest);
    return updatedQuest;
  }

  @override
  Future<LocalDailyQuest> toggleTask({required int index}) async {
    if (box.isEmpty) {
      throw DailyQuestNotFound();
    }
    final lastQuestIndex = box.length - 1;
    LocalDailyQuest quest = box.getAt(lastQuestIndex);
    final updatedQuest = quest.toggleTask(index);
    await box.putAt(lastQuestIndex, updatedQuest);
    return updatedQuest;
  }

  @override
  Future<LocalDailyQuest> removeTask({required int index}) async {
    if (box.isEmpty) {
      throw DailyQuestNotFound();
    }

    final lastQuestIndex = box.length - 1;
    LocalDailyQuest quest = box.getAt(lastQuestIndex);

    if (index >= quest.tasks.length) {
      throw TaskIndexOutOfBound();
    }

    final updatedQuest = quest.removeTask(index);
    await box.putAt(lastQuestIndex, updatedQuest);
    return updatedQuest;
  }

  @override
  Future<LocalDailyQuest> moveTask(
      {required int fromIndex, required int toIndex}) async {
    if (box.isEmpty) {
      throw DailyQuestNotFound();
    }

    final lastQuestIndex = box.length - 1;
    LocalDailyQuest quest = box.getAt(lastQuestIndex);

    if (fromIndex < 0 ||
        fromIndex >= quest.tasks.length ||
        toIndex < 0 ||
        toIndex >= quest.tasks.length) {
      throw TaskIndexOutOfBound();
    }

    final updatedQuest = quest.moveTask(fromIndex, toIndex);
    await box.putAt(lastQuestIndex, updatedQuest);
    return updatedQuest;
  }
}
