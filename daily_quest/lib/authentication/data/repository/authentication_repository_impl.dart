import 'package:daily_quest/authentication/data/datasource/authentication_datasource.dart';
import 'package:daily_quest/authentication/domain/repository/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationDataSource _dataSource;

  AuthenticationRepositoryImpl({required dataSource})
      : _dataSource = dataSource;

  @override
  Future<void> googleSignIn() {
    return _dataSource.googleSignIn();
  }
}
