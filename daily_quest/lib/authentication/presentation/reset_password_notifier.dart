import 'package:daily_quest/authentication/data/repository/authentication_repository_impl.dart';
import 'package:daily_quest/authentication/domain/usecase/reset_password_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/datasource/authentication_datasource_impl.dart';

final class ResetPasswordNotifier extends StateNotifier<AsyncValue<bool>> {
  ResetPasswordNotifier({required resetPasswordUseCase})
      : _resetPasswordUseCase = resetPasswordUseCase,
        super(const AsyncValue.data(false));

  final ResetPasswordUseCase _resetPasswordUseCase;
  resetPassword({required String email}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _resetPasswordUseCase.execute(email: email);
    });
  }
}

final resetPasswordStateProvider =
    StateNotifierProvider<ResetPasswordNotifier, AsyncValue<bool>>((ref) {
  final dataSource = FirebaseAuthenticationDataSource();
  final repository = AuthenticationRepositoryImpl(dataSource: dataSource);
  final resetPasswordUseCase = ResetPasswordUseCaseImpl(repository: repository);
  return ResetPasswordNotifier(resetPasswordUseCase: resetPasswordUseCase);
});
