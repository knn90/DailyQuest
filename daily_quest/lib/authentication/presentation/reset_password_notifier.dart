import 'package:flutter_riverpod/flutter_riverpod.dart';

final class ResetPasswordNotifier extends StateNotifier<AsyncValue<bool>> {
  ResetPasswordNotifier() : super(const AsyncValue.data(false));

  resetPassword() {}
}

final resetPasswordStateProvider =
    StateNotifierProvider<ResetPasswordNotifier, AsyncValue<bool>>((ref) {
  return ResetPasswordNotifier();
});
