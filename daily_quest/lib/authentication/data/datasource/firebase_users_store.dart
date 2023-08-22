import 'package:daily_quest/authentication/data/datasource/users_store.dart';
import 'package:daily_quest/authentication/data/model/remote_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

final class FirebaseUsersStore implements UsersStore {
  DatabaseReference _usersRef;

  FirebaseUsersStore({DatabaseReference? usersRef})
      : _usersRef = usersRef ?? FirebaseDatabase.instance.ref('users') {
    final firebaseApp = Firebase.app();
    final instance = FirebaseDatabase.instanceFor(
        app: firebaseApp,
        databaseURL:
            'https://dailyquest-7272a-default-rtdb.asia-southeast1.firebasedatabase.app/');
    _usersRef = instance.ref('users');
  }
  @override
  Future<void> createIfNotExistUser(String userId) async {
    final user = await getUser(userId);
    if (user != null) {
      return;
    }
    await _usersRef.child(userId).set({
      'user_id': userId,
    });
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
