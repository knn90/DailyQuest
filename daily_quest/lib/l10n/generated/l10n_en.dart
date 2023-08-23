import 'l10n.dart';

/// The translations for English (`en`).
class StringsEn extends Strings {
  StringsEn([String locale = 'en']) : super(locale);

  @override
  String get dailyQuest => 'Daily Quest';

  @override
  String get quest => 'Quest';

  @override
  String get todayChecklists => 'Today checklists';

  @override
  String doneOutOfTaskCount(Object done, Object taskCount) {
    return ' $done out of $taskCount';
  }

  @override
  String get taskTitleHint => 'Title';

  @override
  String get taskDescriptionHint => 'Description';

  @override
  String get addTask => 'Add Task';

  @override
  String get editTask => 'Edit Task';

  @override
  String get submit => 'Submit';

  @override
  String get letStart => 'Let\'s get started';

  @override
  String get or => 'or';

  @override
  String get signup => 'Sign up';

  @override
  String get signinGoogle => 'Sign in with Google';

  @override
  String get signinApple => 'Sign in with Apple';

  @override
  String get signinEmail => 'Sign in with Email';

  @override
  String get signinGuest => 'Continue as a Guest';

  @override
  String get emailTextFieldHint => 'Email';

  @override
  String get passwordTextFieldHint => 'Password';

  @override
  String get invalidEmailAddreddError => 'Please enter a valid email address';

  @override
  String get signInErrorTitle => 'Sign in failed';

  @override
  String get signInCancelledErrorDescription => 'Sign in has been cancelled';

  @override
  String get someThingWentWrongErrorTitle => 'Error';

  @override
  String get someThingWentWrongErrorDescription => 'Something went wrong. Please try again later.';

  @override
  String get userNotFoundErrorDescription => 'Cannot find user with input email address';

  @override
  String get wrongPasswordErrorDescription => 'Invalid email address or password';

  @override
  String get dialogOkButtonTitle => 'OK';

  @override
  String get signUpErrorTitle => 'Sign up failed';

  @override
  String get weakPasswordErrorDescription => 'Your password is too weak, please pick a stronger password.';

  @override
  String get userExistErrorDescription => 'Email address already exists. Please try to login';

  @override
  String get resetPasswordScreenTitle => 'Reset password';

  @override
  String get resetPasswordScreenDescription => 'Enter the email address associated with your account and we\'ll send you a link to reset your password';

  @override
  String get resetPasswordErrorTitle => 'Reset password failed';

  @override
  String get continueButtonTitle => 'Continue';
}
