import 'package:daily_quest/authentication/domain/repository/authentication_repository.dart';
import 'package:daily_quest/authentication/domain/usecase/reset_password_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_password_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AuthenticationRepository>()])
void main() {
  late ResetPasswordUseCaseImpl sut;
  late MockAuthenticationRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthenticationRepository();
    sut = ResetPasswordUseCaseImpl(repository: mockRepository);
  });

  test('should throw when repository throws error', () async {
    // arrange
    const email = 'any@email.com';
    final exception = Exception('reset password fails');
    when(mockRepository.resetPassword(email: email)).thenThrow(exception);
    // act
    expect(() => sut.execute(email: email), throwsException);
    // assert
    verify(mockRepository.resetPassword(email: email));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should forward signin with google message repository', () async {
    // arrange
    const email = 'any@email.com';
    when(mockRepository.resetPassword(email: email))
        .thenAnswer((_) async => true);
    // act
    final result = await sut.execute(email: email);
    // assert
    expect(result, true);
    verify(mockRepository.resetPassword(email: email));
    verifyNoMoreInteractions(mockRepository);
  });
}
