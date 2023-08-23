import 'package:daily_quest/daily_quest/data/datasource/remote/firebase_remote_datasource.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<DatabaseReference>(), MockSpec<DataSnapshot>()])
void main() {
  late FirebaseRemoteDataSource sut;
  late MockDatabaseReference mockRef;
  late MockDataSnapshot mockSnapshot;
}
