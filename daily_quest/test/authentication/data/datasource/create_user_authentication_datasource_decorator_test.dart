import 'package:daily_quest/authentication/data/datasource/authentication_datasource.dart';
import 'package:daily_quest/authentication/data/datasource/create_user_authentication_datasource_decorator.dart';
import 'package:daily_quest/authentication/data/datasource/users_store.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'create_user_authentication_datasource_decorator_test.mocks.dart';

@GenerateNiceMocks(
    [MockSpec<AuthenticationDataSource>(), MockSpec<UsersStore>()])
void main() {
  late CreateUserAuthenticationDataSourceDecorator sut;
  late MockAuthenticationDataSource mockAuthenticationDataSource;
  late MockUsersStore mockUsersStore;
  setUp(() {
    mockAuthenticationDataSource = MockAuthenticationDataSource();
    mockUsersStore = MockUsersStore();
    sut = CreateUserAuthenticationDataSourceDecorator(
      decorated: mockAuthenticationDataSource,
      usersStore: mockUsersStore,
    );
  });

  group('auto sign in', () {
    test('should forward auto signin message to datasource', () async {
      // arrange
      when(mockAuthenticationDataSource.autoSignIn())
          .thenAnswer((_) async => 'any string');
      // act
      final result = await sut.autoSignIn();
      // assert
      expect(result, 'any string');
      verify(mockAuthenticationDataSource.autoSignIn());
      verifyNoMoreInteractions(mockAuthenticationDataSource);
      verifyZeroInteractions(mockUsersStore);
    });
  });

  group('reset password', () {
    test('should forward reset password message to datasource', () async {
      // arrange
      when(mockAuthenticationDataSource.resetPassword(email: 'email'))
          .thenAnswer((_) async => false);
      // act
      final result = await sut.resetPassword(email: 'email');
      // assert
      expect(result, false);
      verify(mockAuthenticationDataSource.resetPassword(email: 'email'));
      verifyNoMoreInteractions(mockAuthenticationDataSource);
      verifyZeroInteractions(mockUsersStore);
    });
  });

  group('email sign in', () {
    test('should forward email signin message to datasource', () async {
      // arrange
      when(mockAuthenticationDataSource.emailSignIn(
              email: 'email', password: 'password'))
          .thenAnswer((_) async => 'any string');
      // act
      final result =
          await sut.emailSignIn(email: 'email', password: 'password');
      // assert
      expect(result, 'any string');
      verify(mockAuthenticationDataSource.emailSignIn(
          email: 'email', password: 'password'));
      verifyNoMoreInteractions(mockAuthenticationDataSource);
      verifyZeroInteractions(mockUsersStore);
    });
  });

  group('google sign in', () {
    test('should forward google signin message to datasource', () async {
      // arrange
      when(mockAuthenticationDataSource.googleSignIn())
          .thenAnswer((_) async => 'any string');
      // act
      final result = await sut.googleSignIn();
      // assert
      expect(result, 'any string');
      verify(mockAuthenticationDataSource.googleSignIn());
      verifyNoMoreInteractions(mockAuthenticationDataSource);
    });

    test('should send create user when datasource return a string ', () async {
      // arrange
      when(mockAuthenticationDataSource.googleSignIn())
          .thenAnswer((_) async => 'any string');
      when(mockUsersStore.createIfNotExistUser()).thenAnswer((_) async => ());
      // act
      final result = await sut.googleSignIn();
      // assert
      expect(result, 'any string');
      verify(mockAuthenticationDataSource.googleSignIn());
      verify(mockUsersStore.createIfNotExistUser());
      verifyNoMoreInteractions(mockAuthenticationDataSource);
    });

    test('should not send create user when datasource return null', () async {
      // arrange
      when(mockAuthenticationDataSource.googleSignIn())
          .thenAnswer((_) async => null);
      when(mockUsersStore.createIfNotExistUser()).thenAnswer((_) async => ());
      // act
      final result = await sut.googleSignIn();
      // assert
      expect(result, null);
      verify(mockAuthenticationDataSource.googleSignIn());
      verifyNoMoreInteractions(mockAuthenticationDataSource);
      verifyZeroInteractions(mockUsersStore);
    });
  });

  group('guest sign in', () {
    test('should forward guest signin message to datasource', () async {
      // arrange
      when(mockAuthenticationDataSource.guestSignIn())
          .thenAnswer((_) async => 'any string');
      // act
      final result = await sut.guestSignIn();
      // assert
      expect(result, 'any string');
      verify(mockAuthenticationDataSource.guestSignIn());
      verifyNoMoreInteractions(mockAuthenticationDataSource);
    });

    test('should send create user when datasource return a string ', () async {
      // arrange
      when(mockAuthenticationDataSource.guestSignIn())
          .thenAnswer((_) async => 'any string');
      when(mockUsersStore.createIfNotExistUser()).thenAnswer((_) async => ());
      // act
      final result = await sut.guestSignIn();
      // assert
      expect(result, 'any string');
      verify(mockAuthenticationDataSource.guestSignIn());
      verify(mockUsersStore.createIfNotExistUser());
      verifyNoMoreInteractions(mockAuthenticationDataSource);
    });

    test('should not send create user when datasource return null', () async {
      // arrange
      when(mockAuthenticationDataSource.guestSignIn())
          .thenAnswer((_) async => null);
      when(mockUsersStore.createIfNotExistUser()).thenAnswer((_) async => ());
      // act
      final result = await sut.guestSignIn();
      // assert
      expect(result, null);
      verify(mockAuthenticationDataSource.guestSignIn());
      verifyNoMoreInteractions(mockAuthenticationDataSource);
      verifyZeroInteractions(mockUsersStore);
    });
  });

  group('sign up', () {
    test('should forward sign up message to datasource', () async {
      // arrange
      when(mockAuthenticationDataSource.signUp(
              email: 'email', password: 'password'))
          .thenAnswer((_) async => 'any string');
      // act
      final result = await sut.signUp(email: 'email', password: 'password');
      // assert
      expect(result, 'any string');
      verify(mockAuthenticationDataSource.signUp(
          email: 'email', password: 'password'));
      verifyNoMoreInteractions(mockAuthenticationDataSource);
    });

    test('should send create user when datasource return a string ', () async {
      // arrange
      when(mockAuthenticationDataSource.signUp(
              email: 'email', password: 'password'))
          .thenAnswer((_) async => 'any string');
      when(mockUsersStore.createIfNotExistUser()).thenAnswer((_) async => ());
      // act
      final result = await sut.signUp(email: 'email', password: 'password');
      // assert
      expect(result, 'any string');
      verify(mockAuthenticationDataSource.signUp(
          email: 'email', password: 'password'));
      verify(mockUsersStore.createIfNotExistUser());
      verifyNoMoreInteractions(mockAuthenticationDataSource);
    });

    test('should not send create user when datasource return null', () async {
      // arrange
      when(mockAuthenticationDataSource.signUp(
              email: 'email', password: 'password'))
          .thenAnswer((_) async => null);
      // act
      final result = await sut.signUp(email: 'email', password: 'password');
      // assert
      expect(result, null);
      verify(mockAuthenticationDataSource.signUp(
          email: 'email', password: 'password'));
      verifyNoMoreInteractions(mockAuthenticationDataSource);
      verifyZeroInteractions(mockUsersStore);
    });
  });
}