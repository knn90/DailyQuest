abstract class SignUpUseCase {
  Future<bool> execute({required String email, required String password});
}

final class SignUpUseCaseImpl implements SignUpUseCase {
  @override
  Future<bool> execute({required String email, required String password}) {
    // TODO: implement execute
    throw UnimplementedError();
  }
}
