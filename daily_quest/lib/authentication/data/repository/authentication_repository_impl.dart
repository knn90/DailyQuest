import 'package:daily_quest/authentication/data/datasource/authentication_datasource.dart';
import 'package:daily_quest/authentication/domain/repository/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationDataSource _dataSource;

  AuthenticationRepositoryImpl({required dataSource})
      : _dataSource = dataSource;

  @override
  Future<bool> googleSignIn() {
    return _dataSource.googleSignIn().then((value) => value != null);
  }

  @override
  Future<bool> autoSignIn() {
    return _dataSource.autoSignIn().then((value) => value != null);
  }

  @override
  Future<bool> emailSignIn({required String email, required String password}) {
    return _dataSource
        .emailSignIn(email: email, password: password)
        .then((value) => value != null);
  }

  @override
  Future<bool> signUp({required String email, required String password}) {
    return _dataSource
        .signUp(email: email, password: password)
        .then((value) => value != null);
  }

  @override
  Future<bool> guestSignIn() {
    return _dataSource.guestSignIn().then((value) => value != null);
  }

  @override
  Future<bool> resetPassword({required String email}) {
    return _dataSource.resetPassword(email: email);
  }
}
