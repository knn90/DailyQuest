import 'package:daily_quest/authentication/domain/repository/authentication_repository.dart';

abstract class SignUpUseCase {
  Future<bool> execute({required String email, required String password});
}

final class SignUpUseCaseImpl implements SignUpUseCase {
  final AuthenticationRepository _repository;

  SignUpUseCaseImpl({required repository}) : _repository = repository;
  @override
  Future<bool> execute({required String email, required String password}) {
    return _repository.signUp(email: email, password: password);
  }
}
