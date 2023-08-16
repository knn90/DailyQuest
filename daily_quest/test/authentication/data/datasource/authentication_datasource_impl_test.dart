import 'package:daily_quest/authentication/data/datasource/authentication_datasource_impl.dart';
import 'package:daily_quest/authentication/domain/exception/authentication_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'authentication_datasource_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseAuth>(),
  MockSpec<User>(),
  MockSpec<UserCredential>(),
])
void main() {
  late AuthenticationDataSourceImpl sut;
  late MockFirebaseAuth mockFirebaseAuth;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    sut = AuthenticationDataSourceImpl(firebaseAuth: mockFirebaseAuth);
  });
  MockUser mockUserWithId(String id) {
    MockUser user = MockUser();
    when(user.uid).thenReturn(id);
    return user;
  }

  MockUserCredential mockUserCredWithWithUser(MockUser? user) {
    MockUserCredential mockUserCred = MockUserCredential();
    when(mockUserCred.user).thenReturn(user);
    return mockUserCred;
  }

  MockUserCredential mockUserCredWithId(String id) {
    MockUser mockUser = mockUserWithId(id);
    MockUserCredential mockUserCred = mockUserCredWithWithUser(mockUser);
    return mockUserCred;
  }

  group('auto sign in ', () {
    test('should return null when current user is null', () async {
      // arrange
      when(mockFirebaseAuth.currentUser).thenReturn(null);
      // act
      final result = await sut.autoSignIn();
      // assert
      expect(result, null);
      verify(mockFirebaseAuth.currentUser);
      verifyNoMoreInteractions(mockFirebaseAuth);
    });

    test('should return user id when current user is not null', () async {
      // arrange
      const userId = 'any user id';
      final mockUser = mockUserWithId(userId);
      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
      // act
      final result = await sut.autoSignIn();
      // assert
      expect(result, userId);
      verify(mockFirebaseAuth.currentUser?.uid);
      verifyNoMoreInteractions(mockFirebaseAuth);
    });
  });

  group('email sign in ', () {
    test(
        'should throw signInUnknownError when firebase throw any FirebaseAuthException ',
        () async {
      // arrange
      final exception = FirebaseAuthException(code: 'any code');
      when(mockFirebaseAuth.signInWithEmailAndPassword(
              email: 'email', password: 'password'))
          .thenThrow(exception);
      // act
      // assert
      expect(() => sut.emailSignIn(email: 'email', password: 'password'),
          throwsA(AuthenticationError.signInUnknownError));
    });

    test('should throw userNotFound when firebase throw user-not-found',
        () async {
      // arrange
      final exception = FirebaseAuthException(code: 'user-not-found');
      when(mockFirebaseAuth.signInWithEmailAndPassword(
              email: 'email', password: 'password'))
          .thenThrow(exception);
      // act
      // assert
      expect(() => sut.emailSignIn(email: 'email', password: 'password'),
          throwsA(AuthenticationError.userNotFound));
    });

    test(
        'should throw wrongUserNamePassword when firebase throw wrong-password',
        () async {
      // arrange
      final exception = FirebaseAuthException(code: 'wrong-password');
      when(mockFirebaseAuth.signInWithEmailAndPassword(
              email: 'email', password: 'password'))
          .thenThrow(exception);
      // act
      // assert
      expect(() => sut.emailSignIn(email: 'email', password: 'password'),
          throwsA(AuthenticationError.wrongUserNamePassword));
    });

    test('should throw SignInUnknowError when firebase throw any other error',
        () async {
      // arrange
      final exception = FirebaseAuthException(code: 'unknown error');
      when(mockFirebaseAuth.signInWithEmailAndPassword(
              email: 'email', password: 'password'))
          .thenThrow(exception);
      // act
      // assert
      expect(() => sut.emailSignIn(email: 'email', password: 'password'),
          throwsA(AuthenticationError.signInUnknownError));
    });

    test('should return null when firebase return no user', () async {
      // arrange
      final mockUserCred = mockUserCredWithWithUser(null);
      when(mockFirebaseAuth.signInWithEmailAndPassword(
              email: 'email', password: 'password'))
          .thenAnswer((_) async => mockUserCred);
      // act
      final result =
          await sut.emailSignIn(email: 'email', password: 'password');
      // assert
      expect(result, null);
      verify(mockFirebaseAuth.signInWithEmailAndPassword(
          email: 'email', password: 'password'));
      verifyNoMoreInteractions(mockFirebaseAuth);
    });

    test('should return user id when firebase return user', () async {
      // arrange
      final mockUserCred = mockUserCredWithId('user id');
      when(mockFirebaseAuth.signInWithEmailAndPassword(
              email: 'email', password: 'password'))
          .thenAnswer((_) async => mockUserCred);
      // act
      final result =
          await sut.emailSignIn(email: 'email', password: 'password');
      // assert
      expect(result, 'user id');
      verify(mockFirebaseAuth.signInWithEmailAndPassword(
          email: 'email', password: 'password'));
      verifyNoMoreInteractions(mockFirebaseAuth);
    });
  });

  group('guest sign in', () {
    test('should return null when firebase return no user', () async {
      // arrange
      final mockUserCred = mockUserCredWithWithUser(null);
      when(mockFirebaseAuth.signInAnonymously())
          .thenAnswer((_) async => mockUserCred);
      // act
      final result = await sut.guestSignIn();
      // assert
      expect(result, null);
    });

    test('should user id when firebase return user', () async {
      // arrange
      final mockUserCred = mockUserCredWithId('user id');
      when(mockFirebaseAuth.signInAnonymously())
          .thenAnswer((_) async => mockUserCred);
      // act
      final result = await sut.guestSignIn();
      // assert
      expect(result, 'user id');
      verify(mockFirebaseAuth.signInAnonymously());
      verifyNoMoreInteractions(mockFirebaseAuth);
    });

    test('should throw SignInUnknowError when firebase throw any error',
        () async {
      // arrange
      final exception = FirebaseAuthException(code: 'unknown error');
      when(mockFirebaseAuth.signInAnonymously()).thenThrow(exception);
      // act
      // assert
      expect(() => sut.guestSignIn(),
          throwsA(AuthenticationError.signInUnknownError));
    });
  });
  group('sign up', () {
    test('should throw weakPasswordError when firebase throw weak-password',
        () async {
      // arrange
      final exception = FirebaseAuthException(code: 'weak-password');
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
              email: 'email', password: 'password'))
          .thenThrow(exception);
      // assert
      expect(() => sut.signUp(email: 'email', password: 'password'),
          throwsA(AuthenticationError.weakPasswordError));
    });

    test('should throw userExistError when firebase throw email-already-in-use',
        () async {
      // arrange
      final exception = FirebaseAuthException(code: 'email-already-in-use');
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
              email: 'email', password: 'password'))
          .thenThrow(exception);
      // assert
      expect(() => sut.signUp(email: 'email', password: 'password'),
          throwsA(AuthenticationError.userExistError));
    });

    test('should throw signUpUnknowError when firebase throw any other error',
        () async {
      // arrange
      final exception = FirebaseAuthException(code: 'any other error');
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
              email: 'email', password: 'password'))
          .thenThrow(exception);
      // assert
      expect(() => sut.signUp(email: 'email', password: 'password'),
          throwsA(AuthenticationError.signUpUnknownError));
    });

    test('should return null when firebase return no user', () async {
      // arrange
      final mockUserCred = mockUserCredWithWithUser(null);
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
              email: 'email', password: 'password'))
          .thenAnswer((_) async => mockUserCred);
      // assert
      final result = await sut.signUp(email: 'email', password: 'password');
      expect(result, null);
      verify(mockFirebaseAuth.createUserWithEmailAndPassword(
          email: 'email', password: 'password'));
      verifyNoMoreInteractions(mockFirebaseAuth);
    });

    test('should return user id when firebase return user', () async {
      // arrange
      const userId = '234823hfzda';
      final mockUserCred = mockUserCredWithId(userId);
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
              email: 'email', password: 'password'))
          .thenAnswer((_) async => mockUserCred);
      // assert
      final result = await sut.signUp(email: 'email', password: 'password');
      expect(result, userId);
      verify(mockFirebaseAuth.createUserWithEmailAndPassword(
          email: 'email', password: 'password'));
      verifyNoMoreInteractions(mockFirebaseAuth);
    });
  });

  group('reset password', () {
    test('should throw userNotFound when firebase throw user-not-found',
        () async {
      // arrange
      final exception = FirebaseAuthException(code: 'user-not-found');
      when(mockFirebaseAuth.sendPasswordResetEmail(email: 'email'))
          .thenThrow(exception);
      // assert
      expect(() => sut.resetPassword(email: 'email'),
          throwsA(AuthenticationError.userNotFound));
    });

    test(
        'should throw resetPasswordUnknowError when firebase throw any other error',
        () async {
      // arrange
      final exception = FirebaseAuthException(code: 'any other error');
      when(mockFirebaseAuth.sendPasswordResetEmail(email: 'email'))
          .thenThrow(exception);
      // assert
      expect(() => sut.resetPassword(email: 'email'),
          throwsA(AuthenticationError.resetPasswordUnknowError));
    });

    test('should return true when firebase does not throw any error', () async {
      // arrange

      when(mockFirebaseAuth.sendPasswordResetEmail(email: 'email'))
          .thenAnswer((_) async => ());
      // act
      final result = await sut.resetPassword(email: 'email');
      // assert
      expect(result, true);
    });
  });
}
