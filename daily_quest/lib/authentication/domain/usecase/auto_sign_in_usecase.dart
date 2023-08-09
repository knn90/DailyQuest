import 'package:daily_quest/authentication/domain/repository/authentication_repository.dart';

abstract class AutoSignInUseCase {
  Future<bool> execute();
}

final class AutoSignInUseCaseImpl implements AutoSignInUseCase {
  final AuthenticationRepository _repository;

  AutoSignInUseCaseImpl({required repository}) : _repository = repository;

  @override
  Future<bool> execute() {
    return _repository.autoSignIn();
  }
}
