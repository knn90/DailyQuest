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

  void mockNonExistUser(String userId) {
    when(mockSnapshot.exists).thenReturn(false);
    when(mockRef.child(userId)).thenReturn(mockRef);
    when(mockRef.get()).thenAnswer((_) async => mockSnapshot);
  }

  void mockExistingUser(String userId) {
    when(mockSnapshot.exists).thenReturn(true);
    when(mockSnapshot.value).thenReturn({'user_id': userId});
    when(mockRef.child(userId)).thenReturn(mockRef);
    when(mockRef.get()).thenAnswer((_) async => mockSnapshot);
  }

  void verifyCreateUser(String userId, RemoteUser remoteUser) {
    verifyInOrder([
      mockRef.child(userId),
      mockRef.set(remoteUser.toJson()),
    ]);
  }

  void verifyGetUser(String userId) {
    verifyInOrder([
      mockRef.child(userId),
      mockRef.get(),
    ]);
  }

  group('getUser', () {
    test('should return null on non exist user', () async {
      // arrange
      const userId = 'any id';
      mockNonExistUser(userId);
      // act
      final result = await sut.getUser(userId);
      // assert
      expect(result, null);
      verifyGetUser(userId);
      verifyNoMoreInteractions(mockRef);
    });

    test('should return user on existing user', () async {
      // arrange
      const userId = 'any id';
      const remoteUser = RemoteUser(id: userId);
      mockExistingUser(userId);
      // act
      final result = await sut.getUser(userId);
      // assert
      expect(result?.id, remoteUser.id);
      verifyGetUser(userId);
      verifyNoMoreInteractions(mockRef);
    });
  });

  group('createIfNotExistUser', () {
    test('should return on existing user', () async {
      // arrange
      const userId = 'any id';
      mockExistingUser(userId);
      // act
      await sut.createIfNotExistUser(userId);
      // assert
      verifyGetUser(userId);
      verifyNoMoreInteractions(mockRef);
    });

    test('should create new user on non existing user', () async {
      // arrange
      const userId = 'any id';
      const remoteUser = RemoteUser(id: userId);
      mockNonExistUser(userId);
      // act
      await sut.createIfNotExistUser(userId);
      // assert
      verifyGetUser(userId);
      verifyCreateUser(userId, remoteUser);
      verifyNoMoreInteractions(mockRef);
    });
  });
}
