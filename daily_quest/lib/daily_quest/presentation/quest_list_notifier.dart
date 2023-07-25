import 'package:daily_quest/daily_quest/domain/entity/daily_quest.dart';
import 'package:daily_quest/daily_quest/domain/usecase/add_task_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/entity/task.dart';
import '../domain/usecase/get_today_quest_usecase.dart';

class QuestListNotifier extends StateNotifier<AsyncValue<DailyQuest>> {
  QuestListNotifier({
    required this.ref,
    required GetTodayQuestUseCase getTodayQuestUseCase,
    required AddTaskUseCase addTaskUseCase,
  })  : _getTodayQuestUseCase = getTodayQuestUseCase,
        _addTaskUseCase = addTaskUseCase,
        super(const AsyncValue.loading()) {
    getTodayQuest();
  }
  final Ref ref;
  final GetTodayQuestUseCase _getTodayQuestUseCase;
  final AddTaskUseCase _addTaskUseCase;

  getTodayQuest() async {
    state = const AsyncValue.loading();
    try {
      final quest = await _getTodayQuestUseCase.execute();
      state = AsyncValue.data(quest);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  addTask(Task task) async {
    state = const AsyncValue.loading();
    try {
      final updatedQuest = await _addTaskUseCase.execute(task);
      state = AsyncValue.data(updatedQuest);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
