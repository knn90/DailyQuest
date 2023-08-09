import 'package:daily_quest/authentication/data/datasource/authentication_datasource_impl.dart';
import 'package:daily_quest/authentication/data/repository/authentication_repository_impl.dart';
import 'package:daily_quest/authentication/domain/usecase/auto_sign_in_usecase.dart';
import 'package:daily_quest/authentication/domain/usecase/google_sign_in_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInNotifier extends StateNotifier<AsyncValue<bool>> {
  SignInNotifier({required googleSignInUseCase, required autoSignInUseCase})
      : _googleSignInUseCase = googleSignInUseCase,
        _autoSignInUseCase = autoSignInUseCase,
        super(const AsyncValue<bool>.data(false));

  final GoogleSignInUseCase _googleSignInUseCase;
  final AutoSignInUseCase _autoSignInUseCase;

  signInWithGoogle() async {
    state = const AsyncValue.loading();
    try {
      final result = await _googleSignInUseCase.execute();
      state = AsyncValue<bool>.data(result);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  autoSignIn() async {
    state = const AsyncValue.loading();
    try {
      final result = await _autoSignInUseCase.execute();
      state = AsyncValue<bool>.data(result);
    } catch (_) {
      state = const AsyncValue.data(false);
    }
  }
}

final signInStateProvider =
    StateNotifierProvider<SignInNotifier, AsyncValue<bool>>((ref) {
  final dataSource = AuthenticationDataSourceImpl();
  final repository = AuthenticationRepositoryImpl(dataSource: dataSource);
  final googleSignInUseCase = GoogleSignInUseCaseImpl(repository: repository);
  final autoSignInUseCase = AutoSignInUseCaseImpl();
  return SignInNotifier(
    googleSignInUseCase: googleSignInUseCase,
    autoSignInUseCase: autoSignInUseCase,
  );
});
