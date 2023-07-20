import 'package:daily_quest/daily_quest/domain/entity/daily_quest.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/usecase/get_today_quest_usecase.dart';

class QuestListNotifier extends StateNotifier<AsyncValue<DailyQuest>> {
  QuestListNotifier(this.ref, this.usecase)
      : super(const AsyncValue.loading()) {
    getTodayQuest();
  }
  final Ref ref;
  final GetTodayQuestUseCase usecase;

  getTodayQuest() async {
    state = const AsyncValue.loading();
    try {
      final quest = await usecase.execute();
      state = AsyncValue.data(quest);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  addTask() {}
}
