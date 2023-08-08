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
}
