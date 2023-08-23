import 'package:flutter/material.dart';

import '../../../l10n/generated/l10n.dart';

enum AuthenticationError implements Exception {
  userNotFound,
  wrongUserNamePassword,
  signInUnknownError,
  signInCancelled,
  weakPasswordError,
  userExistError,
  signUpUnknownError,
  resetPasswordUnknowError,
}

extension AuthenticationErrorParsing on AuthenticationError {
  String title(BuildContext context) {
    final strings = Strings.of(context);
    switch (this) {
      case AuthenticationError.userNotFound:
      case AuthenticationError.wrongUserNamePassword:
      case AuthenticationError.signInCancelled:
      case AuthenticationError.signInUnknownError:
        return strings.signInErrorTitle;
      case AuthenticationError.weakPasswordError:
      case AuthenticationError.userExistError:
      case AuthenticationError.signUpUnknownError:
        return strings.signUpErrorTitle;
      case AuthenticationError.resetPasswordUnknowError:
        return strings.resetPasswordErrorTitle;
      default:
        return strings.someThingWentWrongErrorDescription;
    }
  }

  String description(BuildContext context) {
    final strings = Strings.of(context);
    switch (this) {
      case AuthenticationError.signInCancelled:
        return strings.signInCancelledErrorDescription;
      case AuthenticationError.userNotFound:
        return strings.userNotFoundErrorDescription;
      case AuthenticationError.wrongUserNamePassword:
        return strings.wrongPasswordErrorDescription;
      case AuthenticationError.weakPasswordError:
        return strings.weakPasswordErrorDescription;
      case AuthenticationError.userExistError:
        return strings.userExistErrorDescription;
      default:
        return strings.someThingWentWrongErrorDescription;
    }
  }
}
