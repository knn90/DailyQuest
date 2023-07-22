import 'package:daily_quest/daily_quest/data/datasource/daily_quest_local_datasource.dart';
import 'package:daily_quest/daily_quest/data/model/local_daily_quest.dart';
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
  Future<void> update({required LocalDailyQuest quest}) async {
    if (box.isEmpty) {
      throw DailyQuestNotFound();
    }
    return await box.putAt(box.length - 1, quest);
  }
}
