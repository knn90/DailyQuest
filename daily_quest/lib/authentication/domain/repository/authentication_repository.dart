abstract class AuthenticationRepository {
  Future<bool> autoSignIn();
  Future<bool> googleSignIn();
  Future<bool> guestSignIn();
  Future<bool> emailSignIn({required String email, required String password});
  Future<bool> signUp({required String email, required String password});
  Future<bool> resetPassword();
}
