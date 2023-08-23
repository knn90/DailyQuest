import 'package:daily_quest/daily_quest/data/datasource/remote/firebase_remote_datasource.dart';
import 'package:daily_quest/daily_quest/data/model/remote/remote_daily_quest.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

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
  group('get last', () {
    test('should get quest with correct timestamp', () async {
      // arrange
      const timestamp = 'any timestamp';
      const remoteQuest = RemoteDailyQuest(timestamp: timestamp, tasks: []);
      when(mockRef.child(userId)).thenReturn(mockRef);
      when(mockRef.child(timestamp)).thenReturn(mockRef);
      when(mockRef.get()).thenAnswer((_) async => mockSnapshot);
      when(mockSnapshot.value).thenReturn(remoteQuest.toJson());
      // act
      final result = await sut.getLast();
      // assert
      expect(result, remoteQuest);
      verifyInOrder([
        mockRef.child(userId),
        mockRef.child(timestamp),
        mockRef.get(),
      ]);
    });
  });
}
