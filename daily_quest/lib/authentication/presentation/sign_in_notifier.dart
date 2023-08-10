import 'package:daily_quest/authentication/data/datasource/authentication_datasource_impl.dart';
import 'package:daily_quest/authentication/data/repository/authentication_repository_impl.dart';
import 'package:daily_quest/authentication/domain/usecase/auto_sign_in_usecase.dart';
import 'package:daily_quest/authentication/domain/usecase/email_sign_in_usecase.dart';
import 'package:daily_quest/authentication/domain/usecase/google_sign_in_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInNotifier extends StateNotifier<AsyncValue<bool>> {
  SignInNotifier({
    required autoSignInUseCase,
    required googleSignInUseCase,
    required emailSignInUseCase,
  })  : _autoSignInUseCase = autoSignInUseCase,
        _googleSignInUseCase = googleSignInUseCase,
        _emailSignInUseCase = emailSignInUseCase,
        super(const AsyncValue<bool>.loading()) {
    autoSignIn();
  }
  final AutoSignInUseCase _autoSignInUseCase;
  final GoogleSignInUseCase _googleSignInUseCase;
  final EmailSignInUseCase _emailSignInUseCase;

  autoSignIn() async {
    state = const AsyncValue.loading();
    try {
      final result = await _autoSignInUseCase.execute();
      state = AsyncValue<bool>.data(result);
    } catch (_) {
      state = const AsyncValue.data(false);
    }
  }

  signInWithGoogle() async {
    state = const AsyncValue.loading();
    try {
      final result = await _googleSignInUseCase.execute();
      state = AsyncValue<bool>.data(result);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  signInWithEmail() async {
    state = const AsyncValue.loading();
    try {
      final result = await _emailSignInUseCase.execute();
      state = AsyncValue<bool>.data(result);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

final signInStateProvider =
    StateNotifierProvider<SignInNotifier, AsyncValue<bool>>((ref) {
  final dataSource = AuthenticationDataSourceImpl();
  final repository = AuthenticationRepositoryImpl(dataSource: dataSource);
  final googleSignInUseCase = GoogleSignInUseCaseImpl(repository: repository);
  final autoSignInUseCase = AutoSignInUseCaseImpl(repository: repository);
  final emailSignInUseCase = EmailSignInUseCaseImpl(repository: repository);
  return SignInNotifier(
    autoSignInUseCase: autoSignInUseCase,
    googleSignInUseCase: googleSignInUseCase,
    emailSignInUseCase: emailSignInUseCase,
  );
});
