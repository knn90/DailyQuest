import 'package:daily_quest/daily_quest/domain/entity/quest.dart';
import 'package:mockito/annotations.dart';

abstract class DailyQuestRepository {}

class CreateDailyQuestUseCase {
  final DailyQuestRepository repository;

  CreateDailyQuestUseCase({required this.repository});
  Future<Quest> execute() {
    return Future(() => Quest(title: "title"));
  }
}

@GenerateNiceMocks([MockSpec<DailyQuestRepository>()])
void main() {}
