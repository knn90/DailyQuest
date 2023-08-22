import 'package:daily_quest/authentication/data/datasource/create_user_authentication_datasource_decorator.dart';
import 'package:daily_quest/authentication/data/datasource/firebase_authentication_datasource.dart';
import 'package:daily_quest/authentication/data/datasource/firebase_users_store.dart';
import 'package:daily_quest/authentication/data/repository/authentication_repository_impl.dart';
import 'package:daily_quest/authentication/domain/usecase/auto_sign_in_usecase.dart';
import 'package:daily_quest/authentication/domain/usecase/email_sign_in_usecase.dart';
import 'package:daily_quest/authentication/domain/usecase/google_sign_in_usecase.dart';
import 'package:daily_quest/authentication/domain/usecase/guest_sign_in_usecase.dart';
import 'package:daily_quest/authentication/domain/usecase/sign_up_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class SignInNotifier extends StateNotifier<AsyncValue<bool>> {
  SignInNotifier({
    required autoSignInUseCase,
    required googleSignInUseCase,
    required emailSignInUseCase,
    required guestSignInUseCase,
    required signUpUseCase,
  })  : _autoSignInUseCase = autoSignInUseCase,
        _googleSignInUseCase = googleSignInUseCase,
        _emailSignInUseCase = emailSignInUseCase,
        _guestSignInUseCase = guestSignInUseCase,
        _signUpUseCase = signUpUseCase,
        super(const AsyncValue<bool>.loading()) {
    autoSignIn();
  }
  final AutoSignInUseCase _autoSignInUseCase;
  final GoogleSignInUseCase _googleSignInUseCase;
  final EmailSignInUseCase _emailSignInUseCase;
  final GuestSignInUseCase _guestSignInUseCase;
  final SignUpUseCase _signUpUseCase;

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
      state = AsyncValue.data(await _googleSignInUseCase.execute());
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  signInWithEmail({required String email, required String password}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _emailSignInUseCase.execute(
          email: email, password: password);
    });
  }

  signInAsGuest() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _guestSignInUseCase.execute();
    });
  }

  signUp({required String email, required String password}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _signUpUseCase.execute(email: email, password: password);
    });
  }
}

final signInStateProvider =
    StateNotifierProvider<SignInNotifier, AsyncValue<bool>>((ref) {
  final dataSource = FirebaseAuthenticationDataSource();
  final usersStore = FirebaseUsersStore();
  final createUserIfNeededDecorator =
      CreateUserAuthenticationDataSourceDecorator(
    decorated: dataSource,
    usersStore: usersStore,
  );
  final repository =
      AuthenticationRepositoryImpl(dataSource: createUserIfNeededDecorator);
  final googleSignInUseCase = GoogleSignInUseCaseImpl(repository: repository);
  final autoSignInUseCase = AutoSignInUseCaseImpl(repository: repository);
  final emailSignInUseCase = EmailSignInUseCaseImpl(repository: repository);
  final guestSignInUseCase = GuestSignInUseCaseImpl(repository: repository);
  final signUpUseCase = SignUpUseCaseImpl(repository: repository);
  return SignInNotifier(
    autoSignInUseCase: autoSignInUseCase,
    googleSignInUseCase: googleSignInUseCase,
    emailSignInUseCase: emailSignInUseCase,
    guestSignInUseCase: guestSignInUseCase,
    signUpUseCase: signUpUseCase,
  );
});
