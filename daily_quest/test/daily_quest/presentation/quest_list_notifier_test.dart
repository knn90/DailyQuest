import 'package:daily_quest/daily_quest/domain/entity/daily_quest.dart';
import 'package:daily_quest/daily_quest/domain/usecase/get_today_quest_usecase.dart';
import 'package:daily_quest/daily_quest/presentation/quest_list_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'quest_list_notifier_test.mocks.dart';

@GenerateNiceMocks([MockSpec<GetTodayQuestUseCase>(), MockSpec<Ref>()])
void main() {
  late QuestListNotifier questListNotifier;
  late MockGetTodayQuestUseCase mockUseCase;
  late MockRef mockRef;

  setUp(() {
    mockUseCase = MockGetTodayQuestUseCase();
    mockRef = MockRef();
    questListNotifier = QuestListNotifier(mockRef, mockUseCase);
  });

  group('getTodayQuest', () {
    test(
      'should return correct quest on success',
      () async {
        const quest = DailyQuest(timestamp: 'timestamp', tasks: []);
        // arrange
        when(mockUseCase.execute()).thenAnswer((_) async => quest);
        expectLater(
            questListNotifier.stream,
            emitsInOrder(const [
              AsyncLoading<DailyQuest>(),
              AsyncData<DailyQuest>(quest),
            ]));
        // act
        await questListNotifier.getTodayQuest();
        // assert
        verify(mockUseCase.execute());
      },
      timeout: const Timeout(Duration(milliseconds: 500)),
    );
    test(
      'should return exception on failure',
      () async {
        // arrange
        final exception = Exception('any exception');
        when(mockUseCase.execute()).thenThrow(exception);
        expectLater(
            questListNotifier.stream,
            emitsInOrder([
              const AsyncLoading<DailyQuest>(),
              predicate<AsyncValue<DailyQuest>>((value) {
                expect(value, isA<AsyncError<DailyQuest>>());
                return true;
              }),
            ]));
        // act
        await questListNotifier.getTodayQuest();
        // assert
        verify(mockUseCase.execute());
      },
      timeout: const Timeout(Duration(milliseconds: 500)),
    );
  });
}
