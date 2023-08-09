abstract class AuthenticationRepository {
  Future<bool> googleSignIn();
  Future<bool> autoSignIn();
}
