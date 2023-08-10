import 'package:daily_quest/authentication/domain/repository/authentication_repository.dart';

abstract class EmailSignInUseCase {
  Future<bool> execute({required String email, required String password});
}

final class EmailSignInUseCaseImpl implements EmailSignInUseCase {
  final AuthenticationRepository _repository;

  EmailSignInUseCaseImpl({required repository}) : _repository = repository;

  @override
  Future<bool> execute({required String email, required String password}) {
    return _repository.emailSignIn(email: email, password: password);
  }
}
