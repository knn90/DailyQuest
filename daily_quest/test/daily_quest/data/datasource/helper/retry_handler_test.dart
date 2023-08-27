import 'package:daily_quest/daily_quest/data/datasource/helper/retry_handler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late RetryHandler sut;

  group('on call back throw', () {
    test('should retry when callback throw', () async {
      // arrange
      sut = RetryHandler(maxRetryAttempt: 2);
      var callCount = 0;
      callback() {
        callCount += 1;
        throw (Exception('any exception'));
      }

      // act
      sut.retryOnThrow(callback);
      // assert
      expect(callCount, 3);
    });
  });

  test('should stop retry on callback success', () async {
    // arrange
    sut = RetryHandler(maxRetryAttempt: 2);
    var callCount = 0;
    callback() {
      callCount += 1;
    }

    // act
    sut.retryOnThrow(callback);
    // assert
    expect(callCount, 1);
  });
}
