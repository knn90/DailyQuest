import 'package:daily_quest/daily_quest/data/datasource/daily_quest_local_datasource.dart';
import 'package:daily_quest/daily_quest/data/model/local_daily_quest.dart';
import 'package:daily_quest/daily_quest/data/model/local_task.dart';
import 'package:daily_quest/daily_quest/domain/exception/exceptions.dart';
import 'package:hive/hive.dart';

class DailyQuestLocalDataSourceImpl implements DailyQuestLocalDataSource {
  final Box box;

  DailyQuestLocalDataSourceImpl({required this.box});
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
  Future<LocalDailyQuest> toggleTask(
      {required LocalTask task, required int index}) async {
    if (box.isEmpty) {
      throw DailyQuestNotFound();
    }
    final lastQuestIndex = box.length - 1;
    LocalDailyQuest quest = box.getAt(lastQuestIndex);
    final updatedQuest = quest.toggleTask(index);
    await box.putAt(lastQuestIndex, updatedQuest);
    return updatedQuest;
  }
}
