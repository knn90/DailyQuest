import '../../domain/entity/daily_quest.dart';
import '../../domain/entity/task.dart';
import '../../domain/repository/daily_quest_repository.dart';
import '../datasource/daily_quest_local_datasource.dart';
import '../model/local_daily_quest.dart';

class DailyQuestRepositoryImpl implements DailyQuestRepository {
  final DailyQuestLocalDataSource dataSource;

  DailyQuestRepositoryImpl({required this.dataSource});

  @override
  Future<DailyQuest> getLastDailyQuest() async {
    final localQuest = await dataSource.getLast();
    final tasks = localQuest.tasks
        .map((e) => Task(
              title: e.title,
              description: e.description,
            ))
        .toList();
    return DailyQuest(
      id: localQuest.id,
      timestamp: localQuest.timestamp,
      tasks: tasks,
    );
  }

  @override
  insertDailyQuest({required DailyQuest quest}) async {
    return await dataSource.save(quest: LocalDailyQuest.fromEntity(quest));
  }
}