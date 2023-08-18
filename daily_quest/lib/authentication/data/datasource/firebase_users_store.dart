import 'package:daily_quest/authentication/data/datasource/users_store.dart';
import 'package:daily_quest/authentication/data/model/remote_user.dart';
import 'package:firebase_database/firebase_database.dart';

final class FirebaseUsersStore implements UsersStore {
  final DatabaseReference _usersRef;

  FirebaseUsersStore({DatabaseReference? usersRef})
      : _usersRef = usersRef ?? FirebaseDatabase.instance.ref('Users');
  @override
  Future<void> createIfNotExistUser() {
    // TODO: implement createIfNotExistUser
    throw UnimplementedError();
  }

  @override
  Future<RemoteUser?> getUser(String userId) async {
    final snapshot = await _usersRef.child(userId).get();
    if (snapshot.exists) {
      return RemoteUser(id: userId);
    } else {
      return null;
    }
  }
}
