import 'package:daily_quest/daily_quest/data/datasource/daily_quest_local_datasource.dart';
import 'package:daily_quest/daily_quest/data/model/local_daily_quest.dart';
import 'package:hive/hive.dart';

class DailyQuestLocalDataSourceImpl implements DailyQuestLocalDataSource {
  final Box box;

  DailyQuestLocalDataSourceImpl({required this.box});
  @override
  LocalDailyQuest getLast() {
    return box.getAt(box.length - 1);
  }

  @override
  Future<void> insert({required LocalDailyQuest quest}) async {
    await box.add(quest);
    return;
  }
}
