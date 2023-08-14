import 'package:daily_quest/authentication/domain/repository/authentication_repository.dart';

abstract class ResetPasswordUseCase {
  Future<bool> execute();
}

final class ResetPasswordUseCaseImpl implements ResetPasswordUseCase {
  final AuthenticationRepository _repository;

  ResetPasswordUseCaseImpl({required repository}) : _repository = repository;
  @override
  Future<bool> execute() {
    return _repository.resetPassword();
  }
}
