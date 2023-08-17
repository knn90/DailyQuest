import 'package:daily_quest/authentication/data/datasource/user_datasoure.dart';

import 'authentication_datasource.dart';

final class CreateUserAuthenticationDataSourceDecorator
    implements AuthenticationDataSource {
  final AuthenticationDataSource _decorated;
  final UsersStore _userDataSource;
  CreateUserAuthenticationDataSourceDecorator({
    required AuthenticationDataSource decorated,
    required UsersStore userDataSource,
  })  : _decorated = decorated,
        _userDataSource = userDataSource;

  @override
  Future<String?> autoSignIn() {
    return _decorated.autoSignIn();
  }

  @override
  Future<String?> emailSignIn(
      {required String email, required String password}) {
    return _decorated.emailSignIn(email: email, password: password);
  }

  @override
  Future<String?> googleSignIn() async {
    final userId = await _decorated.googleSignIn();
    if (userId != null) {
      _userDataSource.createIfNotExistUser();
    }
    return userId;
  }

  @override
  Future<String?> guestSignIn() {
    // TODO: implement guestSignIn
    throw UnimplementedError();
  }

  @override
  Future<bool> resetPassword({required String email}) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<String?> signUp({required String email, required String password}) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
