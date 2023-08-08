import 'package:daily_quest/authentication/data/datasource/authentication_datasource_impl.dart';
import 'package:daily_quest/authentication/data/repository/authentication_repository_impl.dart';
import 'package:daily_quest/authentication/domain/usecase/google_sign_in_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginNotifier extends StateNotifier<AsyncValue<bool>> {
  LoginNotifier({required googleSignInUseCase})
      : _googleSignInUseCase = googleSignInUseCase,
        super(const AsyncValue<bool>.data(false));

  final GoogleSignInUseCase _googleSignInUseCase;

  signInWithGoogle() async {
    state = const AsyncValue.loading();
    try {
      final result = await _googleSignInUseCase.execute();
      state = AsyncValue<bool>.data(result);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

final loginProvider =
    StateNotifierProvider<LoginNotifier, AsyncValue<bool>>((ref) {
  final dataSource = AuthenticationDataSourceImpl();
  final repository = AuthenticationRepositoryImpl(dataSource: dataSource);
  final googleSignInUseCase = GoogleSignInUseCaseImpl(repository: repository);
  return LoginNotifier(googleSignInUseCase: googleSignInUseCase);
});
