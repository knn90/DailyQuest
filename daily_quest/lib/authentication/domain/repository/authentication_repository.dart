abstract class AuthenticationRepository {
  Future<bool> autoSignIn();
  Future<bool> googleSignIn();
  Future<bool> emailSignIn();
}
