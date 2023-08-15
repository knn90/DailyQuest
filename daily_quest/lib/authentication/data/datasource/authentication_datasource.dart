abstract class AuthenticationDataSource {
  Future<String> autoSignIn();
  Future<String> googleSignIn();
  Future<String> guestSignIn();
  Future<String> emailSignIn({required String email, required String password});
  Future<String> signUp({required String email, required String password});
  Future<bool> resetPassword({required String email});
}
