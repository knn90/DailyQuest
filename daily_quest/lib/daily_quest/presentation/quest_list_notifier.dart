import 'package:daily_quest/daily_quest/domain/usecase/get_today_quest_usecase.dart';
import 'package:flutter/material.dart';

class QuestListViewModel extends ChangeNotifier {
  final GetTodayQuestUseCase getTodayQuest;

  QuestListViewModel({required this.getTodayQuest});
}
