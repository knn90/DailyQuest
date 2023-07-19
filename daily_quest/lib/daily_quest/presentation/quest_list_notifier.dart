import 'package:daily_quest/daily_quest/domain/entity/daily_quest.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestListViewModel extends StateNotifier<AsyncValue<DailyQuest>> {
  QuestListViewModel() : super(const AsyncValue.loading());
}
