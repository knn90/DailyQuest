import 'package:daily_quest/authentication/domain/usecase/auto_sign_in_usecase.dart';
import 'package:daily_quest/authentication/domain/usecase/email_sign_in_usecase.dart';
import 'package:daily_quest/authentication/domain/usecase/google_sign_in_usecase.dart';
import 'package:daily_quest/authentication/presentation/sign_in_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sign_in_notifier_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GoogleSignInUseCase>(),
  MockSpec<AutoSignInUseCase>(),
  MockSpec<EmailSignInUseCase>(),
])
void main() {
  late SignInNotifier sut;
  late MockGoogleSignInUseCase mockGoogleSignInUseCase;
  late MockAutoSignInUseCase mockAutoSignInUseCase;
  late MockEmailSignInUseCase mockEmailSignInUseCase;

  setUp(() {
    mockGoogleSignInUseCase = MockGoogleSignInUseCase();
    mockAutoSignInUseCase = MockAutoSignInUseCase();
    mockEmailSignInUseCase = MockEmailSignInUseCase();
    sut = SignInNotifier(
      googleSignInUseCase: mockGoogleSignInUseCase,
      autoSignInUseCase: mockAutoSignInUseCase,
      emailSignInUseCase: mockEmailSignInUseCase,
    );
  });
  group('Auto Sign In', () {
    test(
      'should return false on usecase throw',
      () async {
        // arrange
        final exception = Exception('Auto Sign in fails');
        when(mockAutoSignInUseCase.execute()).thenThrow(exception);
        expectLater(
            sut.stream,
            emitsInOrder([
              const AsyncLoading<bool>(),
              const AsyncValue<bool>.data(false),
            ]));
        // act
        await sut.autoSignIn();
        // assert
        verify(mockAutoSignInUseCase.execute());
        verifyNoMoreInteractions(mockAutoSignInUseCase);
      },
      timeout: const Timeout(Duration(milliseconds: 500)),
    );
  });

  test(
    'should return false on usecase return false',
    () async {
      // arrange
      when(mockAutoSignInUseCase.execute()).thenAnswer((_) async => false);
      expectLater(
          sut.stream,
          emitsInOrder([
            const AsyncLoading<bool>(),
            const AsyncValue<bool>.data(false),
          ]));
      // act
      await sut.autoSignIn();
      // assert
      verify(mockAutoSignInUseCase.execute());
      verifyNoMoreInteractions(mockAutoSignInUseCase);
    },
    timeout: const Timeout(Duration(milliseconds: 500)),
  );

  test(
    'should return true on usecase return true',
    () async {
      // arrange
      when(mockAutoSignInUseCase.execute()).thenAnswer((_) async => true);
      expectLater(
          sut.stream,
          emitsInOrder([
            const AsyncLoading<bool>(),
            const AsyncValue<bool>.data(true),
          ]));
      // act
      await sut.autoSignIn();
      // assert
      verify(mockAutoSignInUseCase.execute());
      verifyNoMoreInteractions(mockAutoSignInUseCase);
    },
    timeout: const Timeout(Duration(milliseconds: 500)),
  );
  group('Sign in with Google', () {
    test(
      'should thrown error when use case throws',
      () async {
        // arrange
        when(mockGoogleSignInUseCase.execute()).thenThrow(throwsException);
        expectLater(
            sut.stream,
            emitsInOrder([
              const AsyncLoading<bool>(),
              predicate<AsyncValue<bool>>((value) {
                expect(value, isA<AsyncError<bool>>());
                return true;
              })
            ]));
        // act
        await sut.signInWithGoogle();
        // assert
        verify(mockGoogleSignInUseCase.execute());
        verifyNoMoreInteractions(mockGoogleSignInUseCase);
      },
      timeout: const Timeout(Duration(milliseconds: 500)),
    );

    test(
      'should return true value when usecase success',
      () async {
        // arrange
        when(mockGoogleSignInUseCase.execute()).thenAnswer((_) async => (true));
        expectLater(
          sut.stream,
          emitsInOrder([
            const AsyncLoading<bool>(),
            const AsyncValue<bool>.data(true),
          ]),
        );
        // act
        await sut.signInWithGoogle();
        // assert
        verify(mockGoogleSignInUseCase.execute());
        verifyNoMoreInteractions(mockGoogleSignInUseCase);
      },
      timeout: const Timeout(Duration(milliseconds: 500)),
    );
  });

  group('Sign in with Email', () {
    test(
      'should thrown error when use case throws',
      () async {
        // arrange
        when(mockEmailSignInUseCase.execute()).thenThrow(throwsException);
        expectLater(
            sut.stream,
            emitsInOrder([
              const AsyncLoading<bool>(),
              predicate<AsyncValue<bool>>((value) {
                expect(value, isA<AsyncError<bool>>());
                return true;
              })
            ]));
        // act
        await sut.signInWithEmail();
        // assert
        verify(mockEmailSignInUseCase.execute());
        verifyNoMoreInteractions(mockEmailSignInUseCase);
      },
      timeout: const Timeout(Duration(milliseconds: 500)),
    );

    test(
      'should return true value when usecase success',
      () async {
        // arrange
        when(mockEmailSignInUseCase.execute()).thenAnswer((_) async => (true));
        expectLater(
          sut.stream,
          emitsInOrder([
            const AsyncLoading<bool>(),
            const AsyncValue<bool>.data(true),
          ]),
        );
        // act
        await sut.signInWithEmail();
        // assert
        verify(mockEmailSignInUseCase.execute());
        verifyNoMoreInteractions(mockEmailSignInUseCase);
      },
      timeout: const Timeout(Duration(milliseconds: 500)),
    );
  });
}
