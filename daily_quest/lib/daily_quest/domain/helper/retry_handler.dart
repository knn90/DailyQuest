class RetryHandler {
  final int _maxRetryAttempt;
  int retryCount = 0;

  RetryHandler({int? maxRetryAttempt})
      : _maxRetryAttempt = maxRetryAttempt ?? 5;

  retry(Function callback) {
    if (retryCount > _maxRetryAttempt) {
      return;
    }
    try {
      retryCount += 1;
      callback();
    } catch (e) {
      retry(callback);
    }
  }
}
