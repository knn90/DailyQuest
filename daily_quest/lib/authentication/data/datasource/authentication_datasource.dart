abstract class AuthenticationDataSource {
  Future<bool> autoSignIn();
  Future<bool> googleSignIn();
  Future<bool> emailSignIn({required String email, required String password});
}
