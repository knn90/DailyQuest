import 'package:daily_quest/authentication/data/datasource/authentication_datasource_impl.dart';
import 'package:daily_quest/authentication/data/repository/authentication_repository_impl.dart';
import 'package:daily_quest/authentication/domain/usecase/google_sign_in_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginNotifier extends StateNotifier<AsyncValue<void>> {
  LoginNotifier({required googleSignInUseCase})
      : _googleSignInUseCase = googleSignInUseCase,
        super(const AsyncValue<void>.data(()));

  final GoogleSignInUseCase _googleSignInUseCase;

  signInWithGoogle() async {
    state = const AsyncValue.loading();
    try {
      await _googleSignInUseCase.execute();
      state = const AsyncValue.data(());
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }

    // final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // // Obtain the auth details from the request
    // final GoogleSignInAuthentication? googleAuth =
    //     await googleUser?.authentication;

    // final credential = GoogleAuthProvider.credential(
    //   accessToken: googleAuth?.accessToken,
    //   idToken: googleAuth?.idToken,
    // );

    // final userCred =
    //     await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

final loginProvider =
    StateNotifierProvider<LoginNotifier, AsyncValue<void>>((ref) {
  final dataSource = AuthenticationDataSourceImpl();
  final repository = AuthenticationRepositoryImpl(dataSource: dataSource);
  final googleSignInUseCase = GoogleSignInUseCaseImpl(repository: repository);
  return LoginNotifier(googleSignInUseCase: googleSignInUseCase);
});
