import 'package:daily_quest/authentication/domain/usecase/google_sign_in_usecase.dart';
import 'package:daily_quest/authentication/presentation/log_in_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'log_in_notifier_test.mocks.dart';

@GenerateNiceMocks([MockSpec<GoogleSignInUseCase>()])
void main() {
  late SignInNotifier sut;
  late MockGoogleSignInUseCase mockGoogleSignInUseCase;

  setUp(() {
    mockGoogleSignInUseCase = MockGoogleSignInUseCase();
    sut = SignInNotifier(googleSignInUseCase: mockGoogleSignInUseCase);
  });
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
}
