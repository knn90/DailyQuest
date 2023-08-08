import 'package:daily_quest/authentication/domain/repository/authentication_repository.dart';
import 'package:daily_quest/authentication/domain/usecase/google_sign_in_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'google_sign_in_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AuthenticationRepository>()])
void main() {
  late GoogleSignInUseCaseImpl sut;
  late MockAuthenticationRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthenticationRepository();
    sut = GoogleSignInUseCaseImpl(repository: mockRepository);
  });

  test('should throw when repository throws error', () async {
    // arrange
    final exception = Exception('google sign in fails');
    when(mockRepository.googleSignIn()).thenThrow(exception);
    // act
    expect(() => sut.execute(), throwsException);
    // assert
    verify(mockRepository.googleSignIn());
    verifyNoMoreInteractions(mockRepository);
  });

  test('should forward signin with google message repository', () async {
    // arrange
    when(mockRepository.googleSignIn()).thenAnswer((_) async => true);
    // act
    final result = await sut.execute();
    // assert
    expect(result, true);
    verify(mockRepository.googleSignIn());
    verifyNoMoreInteractions(mockRepository);
  });
}
