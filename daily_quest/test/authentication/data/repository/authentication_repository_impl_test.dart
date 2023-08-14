import 'package:daily_quest/authentication/data/datasource/authentication_datasource.dart';
import 'package:daily_quest/authentication/data/repository/authentication_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'authentication_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AuthenticationDataSource>()])
void main() {
  late AuthenticationRepositoryImpl sut;
  late MockAuthenticationDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockAuthenticationDataSource();
    sut = AuthenticationRepositoryImpl(dataSource: mockDataSource);
  });

  group('autoSignIn', () {
    test('should throw when datasource throw', () async {
      // arrange
      final exception = Exception('Google sign in fails');
      when(mockDataSource.autoSignIn()).thenThrow(exception);
      // act
      expect(() => sut.autoSignIn(), throwsException);
    });

    test('should forward auto sign in message to dataSource', () async {
      // arrange
      when(mockDataSource.autoSignIn()).thenAnswer((_) async => true);
      // act
      final result = await sut.autoSignIn();
      // assert
      expect(result, true);
      verify(mockDataSource.autoSignIn());
      verifyNoMoreInteractions(mockDataSource);
    });
  });

  group('googleSignIn', () {
    test('should throw when datasource throw', () async {
      // arrange
      final exception = Exception('Google sign in fails');
      when(mockDataSource.googleSignIn()).thenThrow(exception);
      // act
      expect(() => sut.googleSignIn(), throwsException);
    });

    test('should forward google sign in message to dataSource', () async {
      // arrange
      when(mockDataSource.googleSignIn()).thenAnswer((_) async => true);
      // act
      final result = await sut.googleSignIn();
      // assert
      expect(result, true);
      verify(mockDataSource.googleSignIn());
      verifyNoMoreInteractions(mockDataSource);
    });
  });

  group('emailSignIn', () {
    test('should throw when datasource throw', () async {
      // arrange
      final exception = Exception('Google sign in fails');
      when(mockDataSource.emailSignIn(email: 'email', password: 'password'))
          .thenThrow(exception);
      // act
      expect(() => sut.emailSignIn(email: 'email', password: 'password'),
          throwsException);
    });

    test('should forward email sign in message to dataSource', () async {
      // arrange
      const email = 'any@email.com';
      const password = 'anypassword';
      when(mockDataSource.emailSignIn(email: email, password: password))
          .thenAnswer((_) async => true);
      // act
      final result = await sut.emailSignIn(email: email, password: password);
      // assert
      expect(result, true);
      verify(mockDataSource.emailSignIn(email: email, password: password));
      verifyNoMoreInteractions(mockDataSource);
    });
  });

  group('guestSignIn', () {
    test('should throw when datasource throw', () async {
      // arrange
      final exception = Exception('Google sign in fails');
      when(mockDataSource.guestSignIn()).thenThrow(exception);
      // act
      expect(() => sut.guestSignIn(), throwsException);
    });

    test('should forward google sign in message to dataSource', () async {
      // arrange
      when(mockDataSource.guestSignIn()).thenAnswer((_) async => true);
      // act
      final result = await sut.guestSignIn();
      // assert
      expect(result, true);
      verify(mockDataSource.guestSignIn());
      verifyNoMoreInteractions(mockDataSource);
    });
  });

  group('signup', () {
    test('should throw when datasource throw', () async {
      // arrange
      final exception = Exception('sign up fails');
      when(mockDataSource.signUp(email: 'email', password: 'password'))
          .thenThrow(exception);
      // act
      expect(() => sut.signUp(email: 'email', password: 'password'),
          throwsException);
    });

    test('should forward signup message to dataSource', () async {
      // arrange
      const email = 'any@email.com';
      const password = 'anypassword';
      when(mockDataSource.signUp(email: email, password: password))
          .thenAnswer((_) async => true);
      // act
      final result = await sut.signUp(email: email, password: password);
      // assert
      expect(result, true);
      verify(mockDataSource.signUp(email: email, password: password));
      verifyNoMoreInteractions(mockDataSource);
    });
  });

  group('reset password', () {
    test('should throw when datasource throw', () async {
      // arrange
      final exception = Exception('reset password fails');
      when(mockDataSource.resetPassword()).thenThrow(exception);
      // act
      expect(() => sut.resetPassword(), throwsException);
    });

    test('should forward signup message to dataSource', () async {
      // arrange
      when(mockDataSource.resetPassword()).thenAnswer((_) async => true);
      // act
      final result = await sut.resetPassword();
      // assert
      expect(result, true);
      verify(mockDataSource.resetPassword());
      verifyNoMoreInteractions(mockDataSource);
    });
  });
}
