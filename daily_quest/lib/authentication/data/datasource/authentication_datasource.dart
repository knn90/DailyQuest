abstract class AuthenticationDataSource {
  Future<bool> googleSignIn();
  Future<bool> autoSignIn();
}
