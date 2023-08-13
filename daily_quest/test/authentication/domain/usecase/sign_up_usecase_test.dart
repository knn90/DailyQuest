import 'package:daily_quest/authentication/domain/repository/authentication_repository.dart';
import 'package:daily_quest/authentication/domain/usecase/sign_up_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sign_up_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AuthenticationRepository>()])
void main() {
  late SignUpUseCaseImpl sut;
  late MockAuthenticationRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthenticationRepository();
    sut = SignUpUseCaseImpl(repository: mockRepository);
  });

  test('should throw when repository throws error', () async {
    // arrange
    final exception = Exception('google sign in fails');
    when(mockRepository.signUp(email: '', password: '')).thenThrow(exception);
    // act
    expect(() => sut.execute(email: '', password: ''), throwsException);
    // assert
    verify(mockRepository.signUp(email: '', password: ''));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should forward signin with google message repository', () async {
    // arrange
    const email = 'any@email.com';
    const password = 'anypassword';
    when(mockRepository.signUp(email: email, password: password))
        .thenAnswer((_) async => true);
    // act
    final result = await sut.execute(email: email, password: password);
    // assert
    expect(result, true);
    verify(mockRepository.signUp(email: email, password: password));
    verifyNoMoreInteractions(mockRepository);
  });
}
