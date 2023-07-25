import 'package:daily_quest/daily_quest/domain/entity/daily_quest.dart';
import 'package:daily_quest/daily_quest/domain/usecase/add_task_usecase.dart';
import 'package:daily_quest/daily_quest/domain/usecase/edit_task_usecase.dart';
import 'package:daily_quest/daily_quest/domain/usecase/toggle_task_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/entity/task.dart';
import '../domain/usecase/get_today_quest_usecase.dart';

class QuestListNotifier extends StateNotifier<AsyncValue<DailyQuest>> {
  QuestListNotifier({
    required this.ref,
    required GetTodayQuestUseCase getTodayQuestUseCase,
    required AddTaskUseCase addTaskUseCase,
    required EditTaskUseCase editTaskUseCase,
    required ToggleTaskUseCase toggleTaskUseCase,
  })  : _getTodayQuestUseCase = getTodayQuestUseCase,
        _addTaskUseCase = addTaskUseCase,
        _editTaskUseCase = editTaskUseCase,
        _toggleTaskUseCase = toggleTaskUseCase,
        super(const AsyncValue.loading()) {
    getTodayQuest();
  }
  final Ref ref;
  final GetTodayQuestUseCase _getTodayQuestUseCase;
  final AddTaskUseCase _addTaskUseCase;
  final EditTaskUseCase _editTaskUseCase;
  final ToggleTaskUseCase _toggleTaskUseCase;

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

  editTask(Task task, int index) async {
    state = const AsyncValue.loading();
    try {
      final updatedQuest = await _editTaskUseCase.editTask(task, index);
      state = AsyncValue.data(updatedQuest);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  toggleTask(int index) async {
    state = const AsyncValue.loading();
    try {
      final updatedQuest = await _toggleTaskUseCase.execute(index);
      state = AsyncValue.data(updatedQuest);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
