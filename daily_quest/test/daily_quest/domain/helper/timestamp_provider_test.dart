import 'package:daily_quest/daily_quest/domain/helper/timestamp_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const epochTimestamp = 1689649219000;
  final testDate = DateTime.fromMillisecondsSinceEpoch(epochTimestamp);
  const epectedTimestamp = '18072023';

  test('should return the timestamp for the date', () {
    // act
    final result = TimestampProvider.timestamp(testDate);
    // assert
    expect(result, epectedTimestamp);
  });

  test('should return correct timestamp 1 second after start day', () async {
    // arrange
    final startOfDate =
        DateTime(testDate.year, testDate.month, testDate.day, 0, 0, 1);
    // act
    final result = TimestampProvider.timestamp(startOfDate);
    // assert
    expect(result, epectedTimestamp);
  });

  test('should return correct timestamp 1 second before end day', () {
    // arrange
    final endOfDate =
        DateTime(testDate.year, testDate.month, testDate.day + 1, 0, 0, -1);
    // act
    final result = TimestampProvider.timestamp(endOfDate);
    // assert
    expect(result, epectedTimestamp);
  });
}
