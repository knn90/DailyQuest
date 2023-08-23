import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_en.dart';

/// Callers can lookup localized strings with an instance of Strings
/// returned by `Strings.of(context)`.
///
/// Applications need to include `Strings.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: Strings.localizationsDelegates,
///   supportedLocales: Strings.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the Strings.supportedLocales
/// property.
abstract class Strings {
  Strings(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static Strings of(BuildContext context) {
    return Localizations.of<Strings>(context, Strings)!;
  }

  static const LocalizationsDelegate<Strings> delegate = _StringsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en')
  ];

  /// The app title
  ///
  /// In en, this message translates to:
  /// **'Daily Quest'**
  String get dailyQuest;

  /// The home screen navigation title
  ///
  /// In en, this message translates to:
  /// **'Quest'**
  String get quest;

  /// The home screen header
  ///
  /// In en, this message translates to:
  /// **'Today checklists'**
  String get todayChecklists;

  /// The home screen header of current status
  ///
  /// In en, this message translates to:
  /// **' {done} out of {taskCount}'**
  String doneOutOfTaskCount(Object done, Object taskCount);

  /// Task details title textfield hint
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get taskTitleHint;

  /// Tast details decription textfield hint
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get taskDescriptionHint;

  /// Add task screen title
  ///
  /// In en, this message translates to:
  /// **'Add Task'**
  String get addTask;

  /// Edit task screen title
  ///
  /// In en, this message translates to:
  /// **'Edit Task'**
  String get editTask;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @letStart.
  ///
  /// In en, this message translates to:
  /// **'Let\'s get started'**
  String get letStart;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signup;

  /// No description provided for @signinGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get signinGoogle;

  /// No description provided for @signinApple.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Apple'**
  String get signinApple;

  /// No description provided for @signinEmail.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Email'**
  String get signinEmail;

  /// No description provided for @signinGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as a Guest'**
  String get signinGuest;

  /// No description provided for @emailTextFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailTextFieldHint;

  /// No description provided for @passwordTextFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordTextFieldHint;

  /// No description provided for @invalidEmailAddreddError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get invalidEmailAddreddError;

  /// No description provided for @signInErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in failed'**
  String get signInErrorTitle;

  /// No description provided for @signInCancelledErrorDescription.
  ///
  /// In en, this message translates to:
  /// **'Sign in has been cancelled'**
  String get signInCancelledErrorDescription;

  /// No description provided for @someThingWentWrongErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get someThingWentWrongErrorTitle;

  /// No description provided for @someThingWentWrongErrorDescription.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again later.'**
  String get someThingWentWrongErrorDescription;

  /// No description provided for @userNotFoundErrorDescription.
  ///
  /// In en, this message translates to:
  /// **'Cannot find user with input email address'**
  String get userNotFoundErrorDescription;

  /// No description provided for @wrongPasswordErrorDescription.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address or password'**
  String get wrongPasswordErrorDescription;

  /// No description provided for @dialogOkButtonTitle.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get dialogOkButtonTitle;

  /// No description provided for @signUpErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign up failed'**
  String get signUpErrorTitle;

  /// No description provided for @weakPasswordErrorDescription.
  ///
  /// In en, this message translates to:
  /// **'Your password is too weak, please pick a stronger password.'**
  String get weakPasswordErrorDescription;

  /// No description provided for @userExistErrorDescription.
  ///
  /// In en, this message translates to:
  /// **'Email address already exists. Please try to login'**
  String get userExistErrorDescription;

  /// No description provided for @resetPasswordScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPasswordScreenTitle;

  /// No description provided for @resetPasswordScreenDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter the email address associated with your account and we\'ll send you a link to reset your password'**
  String get resetPasswordScreenDescription;

  /// No description provided for @resetPasswordErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset password failed'**
  String get resetPasswordErrorTitle;

  /// No description provided for @continueButtonTitle.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButtonTitle;
}

class _StringsDelegate extends LocalizationsDelegate<Strings> {
  const _StringsDelegate();

  @override
  Future<Strings> load(Locale locale) {
    return SynchronousFuture<Strings>(lookupStrings(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_StringsDelegate old) => false;
}

Strings lookupStrings(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return StringsEn();
  }

  throw FlutterError(
    'Strings.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
