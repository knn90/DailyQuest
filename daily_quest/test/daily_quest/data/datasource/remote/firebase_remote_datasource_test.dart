import 'package:daily_quest/daily_quest/data/datasource/remote/firebase_remote_datasource.dart';
import 'package:daily_quest/daily_quest/data/model/remote/remote_daily_quest.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../factory/remote_quest_factory.dart';
import '../../../../factory/remote_task_factory.dart';
import 'firebase_remote_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<DatabaseReference>(), MockSpec<DataSnapshot>()])
void main() {
  late FirebaseRemoteDataSource sut;
  late MockDatabaseReference mockRef;
  late MockDataSnapshot mockSnapshot;
  const userId = 'any user id';
  const timestamp = 'any timestamp';
  setUp(() {
    mockSnapshot = MockDataSnapshot();
    mockRef = MockDatabaseReference();
    sut = FirebaseRemoteDataSource(
      userId: userId,
      timestamp: timestamp,
      dailyQuestRef: mockRef,
    );
  });
  mockPathForUserRef() {
    when(mockRef.child(userId)).thenReturn(mockRef);
    when(mockRef.child(timestamp)).thenReturn(mockRef);
  }

  group('getTodayQuest', () {
    test('should get quest with correct timestamp', () async {
      // arrange
      const remoteQuest = RemoteDailyQuest(timestamp: timestamp, tasks: []);
      mockPathForUserRef();
      when(mockRef.get()).thenAnswer((_) async => mockSnapshot);
      when(mockSnapshot.exists).thenReturn(true);
      when(mockSnapshot.value).thenReturn(remoteQuest.toJson());
      // act
      final result = await sut.getTodayQuest();
      // assert
      expect(result, remoteQuest);
      verifyInOrder([
        mockRef.child(userId),
        mockRef.child(timestamp),
        mockRef.get(),
      ]);
    });

    test('should return null on non-exist snapshot', () async {
      // arrange
      mockPathForUserRef();
      when(mockSnapshot.exists).thenReturn(false);
      when(mockRef.get()).thenAnswer((_) async => mockSnapshot);
      // act
      final result = await sut.getTodayQuest();
      // assert
      expect(result, null);
      verifyInOrder([
        mockRef.child(userId),
        mockRef.child(timestamp),
        mockRef.get(),
      ]);
      verifyNoMoreInteractions(mockRef);
    });
  });

  group('createQuest', () {
    test('should throw on firebase throws error', () async {
      // arrange
      final exception = Exception('create new quest failed');
      final remoteQuest = RemoteDailyQuestFactory.make();
      mockPathForUserRef();
      when(mockRef.set(remoteQuest.toJson())).thenThrow(exception);
      // assert
      expect(() => sut.createQuest(quest: remoteQuest), throwsException);
      verifyInOrder([
        mockRef.child(userId),
        mockRef.child(timestamp),
        mockRef.set(remoteQuest.toJson()),
      ]);
    });

    test('shold return void on firebase create quest successfully', () async {
      // arrange
      final remoteQuest = RemoteDailyQuestFactory.make(
          tasks: RemoteTaskFactory.makeList(count: 1));
      mockPathForUserRef();
      when(mockRef.set(remoteQuest.toJson())).thenAnswer((_) async => ());
      // act
      await sut.createQuest(quest: remoteQuest);
      // assert
      verifyInOrder([
        mockRef.child(userId),
        mockRef.child(timestamp),
        mockRef.set(remoteQuest.toJson()),
      ]);
      verifyNoMoreInteractions(mockRef);
    });
  });

  group('updateQuest', () {
    test('should throw when firebase throw exception', () async {
      // arrange
      final exception = Exception('create new quest failed');
      final remoteQuest = RemoteDailyQuestFactory.make();
      mockPathForUserRef();
      when(mockRef.update(remoteQuest.toJson())).thenThrow(exception);
      // assert
      expect(() => sut.updateQuest(quest: remoteQuest), throwsException);
      verifyInOrder([
        mockRef.child(userId),
        mockRef.child(timestamp),
        mockRef.update(remoteQuest.toJson()),
      ]);
    });

    test('shold return void on firebase update quest successfully', () async {
      // arrange
      final remoteQuest = RemoteDailyQuestFactory.make(
          tasks: RemoteTaskFactory.makeList(count: 1));
      mockPathForUserRef();
      when(mockRef.update(remoteQuest.toJson())).thenAnswer((_) async => ());
      // act
      await sut.updateQuest(quest: remoteQuest);
      // assert;
      verifyInOrder([
        mockRef.child(userId),
        mockRef.child(timestamp),
        mockRef.update(remoteQuest.toJson()),
      ]);
      verifyNoMoreInteractions(mockRef);
    });
  });
}
