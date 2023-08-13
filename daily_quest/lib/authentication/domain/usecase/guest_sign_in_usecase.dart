import '../repository/authentication_repository.dart';

abstract class GuestSignInUseCase {
  Future<bool> execute();
}

final class GuestSignInUseCaseImpl implements GuestSignInUseCase {
  final AuthenticationRepository _repository;

  GuestSignInUseCaseImpl({required repository}) : _repository = repository;

  @override
  Future<bool> execute() {
    return _repository.guestSignIn();
  }
}
