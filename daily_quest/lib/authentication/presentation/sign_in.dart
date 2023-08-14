import 'package:daily_quest/authentication/presentation/sign_in_notifier.dart';
import 'package:daily_quest/authentication/presentation/view/sign_in_button.dart';
import 'package:daily_quest/authentication/presentation/view/sign_in_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/view/loading_indicator.dart';
import '../../shared/strings.dart';
import '../domain/exception/authentication_exception.dart';

class SignInScreen extends ConsumerWidget {
  final VoidCallback _onLoginSucceed;
  final VoidCallback _onResetPasswordPressed;
  const SignInScreen(
      {required onLoginSucceed, required onResetPasswordPressed, super.key})
      : _onLoginSucceed = onLoginSucceed,
        _onResetPasswordPressed = onResetPasswordPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final strings = Strings.of(context);
    _bindSignInState(context, ref);
    return Scaffold(
      appBar: AppBar(title: Text(strings.dailyQuest)),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32.0, vertical: 5),
                child: Text(strings.letStart,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1.5,
                    )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 32, vertical: 5.0),
                    child: EmailLogin(),
                  ),
                  _resetPasswordButton(context),
                  SignInButton.email(
                      context: context,
                      onPressed: () {
                        final email = ref.read(signInEmailProvider);
                        final password = ref.read(signInPasswordProvicer);
                        ref.read(signInStateProvider.notifier).signInWithEmail(
                              email: email,
                              password: password,
                            );
                      }),
                  const SizedBox(height: 10),
                  SignInButton.signUp(
                    context: context,
                    onPressed: () {
                      final email = ref.read(signInEmailProvider);
                      final password = ref.read(signInPasswordProvicer);
                      ref.read(signInStateProvider.notifier).signUp(
                            email: email,
                            password: password,
                          );
                    },
                  ),
                  const SizedBox(height: 20),
                  _orDivider(context),
                  const SizedBox(height: 20),
                  SignInButton.google(
                      context: context,
                      onPressed: () => ref
                          .read(signInStateProvider.notifier)
                          .signInWithGoogle()),
                  const SizedBox(height: 10),
                  SignInButton.guest(
                    context: context,
                    onPressed: () =>
                        ref.read(signInStateProvider.notifier).signInAsGuest(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _orDivider(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.onPrimaryContainer;
    final strings = Strings.of(context);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Divider(
                color: color,
                endIndent: 10,
              ),
            ),
            Text(
              strings.or,
              style: theme.textTheme.bodyMedium?.copyWith(color: color),
            ),
            Expanded(
              child: Divider(color: color, indent: 10),
            ),
          ],
        ));
  }

  Widget _resetPasswordButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 24, bottom: 5),
          child: TextButton(
              onPressed: _onResetPasswordPressed,
              child: Text(Strings.of(context).resetPasswordTitle)),
        ),
      ],
    );
  }

  _bindSignInState(BuildContext context, WidgetRef ref) {
    ref.listen(signInStateProvider, (prev, next) {
      if (next.isLoading) {
        _handleLoading(context);
      } else if (next.hasError) {
        Navigator.of(context).pop();
        _handleSignInError(next.error!, context);
      } else {
        if (next.value ?? false) {
          Navigator.of(context).pop();
          _onLoginSucceed();
        }
      }
    });
  }

  _handleLoading(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(child: LoadingIndicator());
      },
    );
  }

  _handleSignInError(Object error, BuildContext context) {
    final strings = Strings.of(context);
    var errorTitle = '';
    var errorDesciption = '';

    switch (error) {
      case AuthenticationError.userNotFound:
        errorTitle = strings.signInErrorTitle;
        errorDesciption = strings.userNotFoundErrorDescription;
        break;
      case AuthenticationError.wrongUserNamePassword:
        errorTitle = strings.signInErrorTitle;
        errorDesciption = strings.wrongPasswordErrorDescription;
        break;
      case AuthenticationError.signInUnknownError:
        errorTitle = strings.signInErrorTitle;
        errorDesciption = strings.someThingWentWrongErrorDescription;
        break;
      case AuthenticationError.weakPasswordError:
        errorTitle = strings.signUpErrorTitle;
        errorDesciption = strings.weakPasswordErrorDescription;
        break;
      case AuthenticationError.userExistError:
        errorTitle = strings.signUpErrorTitle;
        errorDesciption = strings.userExistErrorDescription;
        break;
      case AuthenticationError.signUpUnknownError:
        errorTitle = strings.signUpErrorTitle;
        errorDesciption = strings.someThingWentWrongErrorDescription;
        break;
      default:
        errorTitle = strings.someThingWentWrongErrorDescription;
        errorDesciption = strings.someThingWentWrongErrorDescription;
    }

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(errorTitle),
          content: Text(errorDesciption),
          actions: <Widget>[
            TextButton(
              child: Text(strings.dialogOkButtonTitle),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
