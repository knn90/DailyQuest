import 'package:daily_quest/daily_quest/domain/usecase/add_task_usecase_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../main.dart';
import '../../data/datasource/daily_quest_local_datasource_impl.dart';
import '../../data/repository/daily_quest_repository_impl.dart';
import '../../domain/entity/daily_quest.dart';
import '../../domain/helper/quest_validator_impl.dart';
import '../../domain/helper/timestamp_provider.dart';
import '../../domain/usecase/get_today_quest_usecase_impl.dart';
import '../quest_list_notifier.dart';

final questListProvider =
    StateNotifierProvider<QuestListNotifier, AsyncValue<DailyQuest>>((ref) {
  final box = Hive.box(dailyQuestBox);
  final dataSource = DailyQuestLocalDataSourceImpl(box: box);
  final repository = DailyQuestRepositoryImpl(dataSource: dataSource);
  final validator =
      QuestValidatorImpl(timestampProvider: TimestampProvider.todayTimestamp);
  final getTodayQuestUseCase = GetTodayQuestUseCaseImpl(
      repository: repository,
      validator: validator,
      timestampProvider: TimestampProvider.todayTimestamp);
  final addTaskUseCase = AddTaskUseCaseImpl(repository: repository);
  return QuestListNotifier(
    ref: ref,
    getTodayQuestUseCase: getTodayQuestUseCase,
    addTaskUseCase: addTaskUseCase,
  );
});
