import 'package:daily_quest/authentication/data/datasource/users_store.dart';

import 'authentication_datasource.dart';

final class CreateUserAuthenticationDataSourceDecorator
    implements AuthenticationDataSource {
  final AuthenticationDataSource _decorated;
  final UsersStore _usersStore;
  CreateUserAuthenticationDataSourceDecorator({
    required AuthenticationDataSource decorated,
    required UsersStore usersStore,
  })  : _decorated = decorated,
        _usersStore = usersStore;

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
      await _usersStore.createIfNotExistUser(userId);
    }
    return userId;
  }

  @override
  Future<String?> guestSignIn() async {
    final userId = await _decorated.guestSignIn();
    if (userId != null) {
      await _usersStore.createIfNotExistUser(userId);
    }
    return userId;
  }

  @override
  Future<bool> resetPassword({required String email}) {
    return _decorated.resetPassword(email: email);
  }

  @override
  Future<String?> signUp(
      {required String email, required String password}) async {
    final userId = await _decorated.signUp(email: email, password: password);
    if (userId != null) {
      _usersStore.createIfNotExistUser(userId);
    }
    return userId;
  }
}
