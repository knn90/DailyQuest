import 'package:daily_quest/authentication/domain/usecase/reset_password_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class ResetPasswordNotifier extends StateNotifier<AsyncValue<bool>> {
  ResetPasswordNotifier({required resetPasswordUseCase})
      : _resetPasswordUseCase = resetPasswordUseCase,
        super(const AsyncValue.data(false));

  final ResetPasswordUseCase _resetPasswordUseCase;
  resetPassword() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _resetPasswordUseCase.execute();
    });
  }
}

final resetPasswordStateProvider =
    StateNotifierProvider<ResetPasswordNotifier, AsyncValue<bool>>((ref) {
  final resetPasswordUseCase = ResetPasswordUseCaseImpl();
  return ResetPasswordNotifier(resetPasswordUseCase: resetPasswordUseCase);
});
