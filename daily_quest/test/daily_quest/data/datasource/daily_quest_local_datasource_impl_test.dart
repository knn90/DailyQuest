import 'package:daily_quest/daily_quest/data/datasource/daily_quest_local_datasource.dart';
import 'package:daily_quest/daily_quest/data/datasource/daily_quest_local_datasource_impl.dart';
import 'package:daily_quest/daily_quest/data/model/local_daily_quest.dart';
import 'package:daily_quest/daily_quest/data/model/local_task.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';

import 'daily_quest_local_datasource_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Box>()])
void main() {
  late DailyQuestLocalDataSource dataSource;
  late MockBox mockBox;
  const oldQuest =
      LocalDailyQuest(id: 'old id', timestamp: 'old timestamp', tasks: []);
  const latestQuest = LocalDailyQuest(
    id: 'latest id',
    timestamp: 'latest timestamp',
    tasks: [
      LocalTask(title: 'latest title', description: 'latest description'),
    ],
  );
  setUp(() {
    mockBox = MockBox();
    dataSource = DailyQuestLocalDataSourceImpl(box: mockBox);
  });

  group('getLast', () {
    test('should get the last inserted quest', () async {
      // arrange
      when(mockBox.length).thenReturn(2);
      when(mockBox.getAt(0)).thenReturn(oldQuest);
      when(mockBox.getAt(1)).thenReturn(latestQuest);
      // act
      final result = dataSource.getLast();
      // assert
      expect(result, latestQuest);
      verify(mockBox.getAt(1));
      verify(mockBox.length);
      verifyNoMoreInteractions(mockBox);
    });
  });

  group('insertQuest', () {
    test('should insert quest to box', () async {
      // arrange
      when(mockBox.add(latestQuest)).thenAnswer((_) async => 0);
      // act
      dataSource.insert(quest: latestQuest);
      // assert
      verify(mockBox.add(latestQuest));
      verifyNoMoreInteractions(mockBox);
    });

    test('called twice should insert to the box twice', () async {
      // arrange
      when(mockBox.add(oldQuest)).thenAnswer((_) async => 0);
      when(mockBox.add(latestQuest)).thenAnswer((_) async => 0);
      // act
      dataSource.insert(quest: oldQuest);
      dataSource.insert(quest: latestQuest);
      // assert
      verify(mockBox.add(oldQuest));
      verify(mockBox.add(latestQuest));
      verifyNoMoreInteractions(mockBox);
    });
  });
}
