import 'package:daily_quest/authentication/domain/repository/authentication_repository.dart';

abstract class GoogleSignInUseCase {
  Future<bool> execute();
}

class GoogleSignInUseCaseImpl implements GoogleSignInUseCase {
  final AuthenticationRepository _repository;

  GoogleSignInUseCaseImpl({required repository}) : _repository = repository;

  @override
  Future<bool> execute() {
    return _repository.googleSignIn();
  }
}
