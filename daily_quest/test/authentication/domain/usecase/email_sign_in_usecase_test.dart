import 'package:daily_quest/authentication/domain/repository/authentication_repository.dart';
import 'package:daily_quest/authentication/domain/usecase/email_sign_in_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'email_sign_in_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AuthenticationRepository>()])
void main() {
  late EmailSignInUseCaseImpl sut;
  late MockAuthenticationRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthenticationRepository();
    sut = EmailSignInUseCaseImpl(repository: mockRepository);
  });

  test('should throw when repository throws error', () async {
    // arrange
    final exception = Exception('google sign in fails');
    when(mockRepository.emailSignIn()).thenThrow(exception);
    // act
    expect(() => sut.execute(), throwsException);
    // assert
    verify(mockRepository.emailSignIn());
    verifyNoMoreInteractions(mockRepository);
  });

  test('should forward signin with google message repository', () async {
    // arrange
    when(mockRepository.emailSignIn()).thenAnswer((_) async => true);
    // act
    final result = await sut.execute();
    // assert
    expect(result, true);
    verify(mockRepository.emailSignIn());
    verifyNoMoreInteractions(mockRepository);
  });
}
