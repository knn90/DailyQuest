import 'package:daily_quest/authentication/data/model/remote_user.dart';

abstract class UsersStore {
  Future<void> createIfNotExistUser();
  Future<RemoteUser?> getUser(String userId);
}
