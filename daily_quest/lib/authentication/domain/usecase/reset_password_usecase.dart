import 'package:daily_quest/authentication/domain/repository/authentication_repository.dart';

abstract class ResetPasswordUseCase {
  Future<bool> execute({required String email});
}

final class ResetPasswordUseCaseImpl implements ResetPasswordUseCase {
  final AuthenticationRepository _repository;

  ResetPasswordUseCaseImpl({required repository}) : _repository = repository;
  @override
  Future<bool> execute({required String email}) {
    return _repository.resetPassword(email: email);
  }
}
