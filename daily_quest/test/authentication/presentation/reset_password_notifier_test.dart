import 'package:daily_quest/authentication/domain/usecase/reset_password_usecase.dart';
import 'package:daily_quest/authentication/presentation/reset_password_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_password_notifier_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ResetPasswordUseCase>()])
void main() {
  late ResetPasswordNotifier sut;
  late MockResetPasswordUseCase mockResetPasswordUseCase;
  setUp(() {
    mockResetPasswordUseCase = MockResetPasswordUseCase();
    sut = ResetPasswordNotifier(resetPasswordUseCase: mockResetPasswordUseCase);
  });

  group('reset password', () {
    test(
      'should throw on usecase throw',
      () async {
        // arrange
        final exception = Exception('reset password fails');
        when(mockResetPasswordUseCase.execute()).thenThrow(exception);
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
        await sut.resetPassword();
        // assert
        verify(mockResetPasswordUseCase.execute());
        verifyNoMoreInteractions(mockResetPasswordUseCase);
      },
      timeout: const Timeout(Duration(milliseconds: 500)),
    );
    test(
      'should return false on usecase return false',
      () async {
        // arrange
        when(mockResetPasswordUseCase.execute()).thenAnswer((_) async => false);
        expectLater(
            sut.stream,
            emitsInOrder([
              const AsyncLoading<bool>(),
              const AsyncValue<bool>.data(false),
            ]));
        // act
        await sut.resetPassword();
        // assert
        verify(mockResetPasswordUseCase.execute());
        verifyNoMoreInteractions(mockResetPasswordUseCase);
      },
      timeout: const Timeout(Duration(milliseconds: 500)),
    );
    test(
      'should return true on usecase return true',
      () async {
        // arrange
        when(mockResetPasswordUseCase.execute()).thenAnswer((_) async => true);
        expectLater(
            sut.stream,
            emitsInOrder([
              const AsyncLoading<bool>(),
              const AsyncValue<bool>.data(true),
            ]));
        // act
        await sut.resetPassword();
        // assert
        verify(mockResetPasswordUseCase.execute());
        verifyNoMoreInteractions(mockResetPasswordUseCase);
      },
      timeout: const Timeout(Duration(milliseconds: 500)),
    );
  });
}
