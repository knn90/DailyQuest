import 'package:daily_quest/authentication/data/datasource/users_store.dart';
import 'package:daily_quest/authentication/data/model/remote_user.dart';
import 'package:firebase_database/firebase_database.dart';

final class FirebaseUsersStore implements UsersStore {
  final DatabaseReference _usersRef;

  FirebaseUsersStore({DatabaseReference? usersRef})
      : _usersRef = usersRef ?? FirebaseDatabase.instance.ref('users');

  @override
  Future<void> createIfNotExistUser(String userId) async {
    final user = await getUser(userId);
    if (user != null) {
      return;
    }
    final createUser = RemoteUser(id: userId);
    await _usersRef.child(userId).set(createUser.toJson());
  }

  @override
  Future<RemoteUser?> getUser(String userId) async {
    final snapshot = await _usersRef.child(userId).get();
    if (snapshot.exists) {
      final map = snapshot.value as Map<String, dynamic>;
      return RemoteUser.fromJson(map);
    } else {
      return null;
    }
  }
}
