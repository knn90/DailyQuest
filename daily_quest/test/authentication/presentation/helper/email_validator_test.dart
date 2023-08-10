import 'package:daily_quest/authentication/presentation/helper/email_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should return false when email is empty', () {
    // act
    final result = EmailValidator.validate('');
    // assert
    expect(result, false);
  });

  test('should return false on invalid email', () {
    // act
    final result = EmailValidator.validate('invalidEmail.com');
    // assert
    expect(result, false);
  });

  test('shoudl return true on valid email', () {
    final result = EmailValidator.validate('valid@email.com');
    // assert
    expect(result, true);
  });
}
