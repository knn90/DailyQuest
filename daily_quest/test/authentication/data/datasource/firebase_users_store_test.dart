import 'package:daily_quest/authentication/data/datasource/firebase_users_store.dart';
import 'package:daily_quest/authentication/data/model/remote_user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'firebase_users_store_test.mocks.dart';

@GenerateNiceMocks([MockSpec<DatabaseReference>(), MockSpec<DataSnapshot>()])
void main() {
  late FirebaseUsersStore sut;
  late MockDatabaseReference mockRef;
  late MockDataSnapshot mockSnapshot;
  setUp(() {
    mockRef = MockDatabaseReference();
    mockSnapshot = MockDataSnapshot();
    sut = FirebaseUsersStore(usersRef: mockRef);
  });

  group('getUser', () {
    test('should return null on non exist user', () async {
      // arrange
      const userId = 'any id';
      when(mockSnapshot.exists).thenReturn(false);
      when(mockRef.child(userId)).thenReturn(mockRef);
      when(mockRef.get()).thenAnswer((_) async => mockSnapshot);
      // act
      final result = await sut.getUser(userId);
      // assert
      expect(result, null);
      verify(mockRef.child(userId));
      verify(mockRef.get());
      verifyNoMoreInteractions(mockRef);
    });

    test('should return user on existing user', () async {
      // arrange
      const userId = 'any id';
      const remoteUser = RemoteUser(id: userId);
      when(mockSnapshot.exists).thenReturn(true);
      when(mockRef.child(userId)).thenReturn(mockRef);
      when(mockRef.get()).thenAnswer((_) async => mockSnapshot);
      // act
      final result = await sut.getUser(userId);
      // assert
      expect(result?.id, remoteUser.id);
      verify(mockRef.child(userId));
      verify(mockRef.get());
      verifyNoMoreInteractions(mockRef);
    });
  });

  group('Create user if not exist', () {
    test('should return on existing user', () async {
      // arrange
      const userId = 'any id';
      when(mockSnapshot.exists).thenReturn(true);
      when(mockRef.child(userId)).thenReturn(mockRef);
      when(mockRef.get()).thenAnswer((_) async => mockSnapshot);
      // act
      await sut.createIfNotExistUser(userId);
      // assert
      verify(mockRef.child(userId));
      verify(mockRef.get());
      verifyNoMoreInteractions(mockRef);
    });

    test('should create new user on non existing user', () async {
      // arrange
      const userId = 'any id';
      const remoteUser = RemoteUser(id: userId);
      when(mockSnapshot.exists).thenReturn(false);
      when(mockRef.child(userId)).thenReturn(mockRef);
      when(mockRef.get()).thenAnswer((_) async => mockSnapshot);
      // act
      await sut.createIfNotExistUser(userId);
      // assert
      verify(mockRef.child(userId));
      verify(mockRef.get());
      verify(mockRef.set(remoteUser.toJson()));
      verifyNoMoreInteractions(mockRef);
    });
  });
}
