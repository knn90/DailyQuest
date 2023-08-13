enum AuthenticationError implements Exception {
  userNotFound,
  wrongUserNamePassword,
  signInUnknownError,
  weakPasswordError,
  userExistError,
  signUpUnknownError,
}
