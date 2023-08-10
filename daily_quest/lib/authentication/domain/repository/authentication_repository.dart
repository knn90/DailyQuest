abstract class AuthenticationRepository {
  Future<bool> autoSignIn();
  Future<bool> googleSignIn();
  Future<bool> emailSignIn({required String email, required String password});
}
