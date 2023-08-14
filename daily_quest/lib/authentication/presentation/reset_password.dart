import 'package:daily_quest/authentication/presentation/reset_password_notifier.dart';
import 'package:daily_quest/authentication/presentation/view/sign_in_button.dart';
import 'package:daily_quest/common/presentation/helper/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/strings.dart';
import '../domain/exception/authentication_exception.dart';
import 'helper/email_validator.dart';

final resetPasswordEmailProvider = StateProvider.autoDispose((ref) => '');

class ResetPasswordScreen extends ConsumerStatefulWidget {
  final VoidCallback _onResetPasswordSucceed;
  const ResetPasswordScreen({required onResetPasswordSucceed, super.key})
      : _onResetPasswordSucceed = onResetPasswordSucceed;

  @override
  ConsumerState createState() => ResetPasswordScreenState();
}

class ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  late TextEditingController _emailController;
  bool _shouldValidateEmail = false;
  bool get _isEmailValid {
    final email = _emailController.value.text;
    return !_shouldValidateEmail || EmailValidator.validate(email);
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StateController<String> email =
        ref.watch(resetPasswordEmailProvider.notifier);
    final strings = Strings.of(context);
    final theme = Theme.of(context);
    _bindResetPasswordState(context);
    return Scaffold(
      appBar: AppBar(title: Text(strings.dailyQuest)),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(strings.resetPasswordScreenTitle,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.5,
                )),
            const SizedBox(height: 10),
            Text(strings.resetPasswordScreenDescription),
            ValueListenableBuilder(
              valueListenable: _emailController,
              builder: (context, value, __) {
                return TextField(
                  decoration: InputDecoration(
                    hintText: strings.emailTextFieldHint,
                    filled: false,
                    errorText:
                        _isEmailValid ? null : strings.invalidEmailAddreddError,
                  ),
                  controller: _emailController,
                  style: theme.textTheme.titleMedium,
                  autofocus: true,
                  maxLines: 1,
                  onChanged: (value) {
                    email.state = value;
                    _shouldValidateEmail = true;
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder(
                valueListenable: _emailController,
                builder: (context, value, __) {
                  return Center(
                      child: SignInButton(
                    title: strings.continueButtonTitle,
                    onPressed: (!_isEmailValid || value.text == '')
                        ? null
                        : () => ref
                            .read(resetPasswordStateProvider.notifier)
                            .resetPassword(email: email.state),
                  ));
                })
          ],
        ),
      )),
    );
  }

  _bindResetPasswordState(BuildContext context) {
    ref.listen(resetPasswordStateProvider, (prev, next) {
      if (next.isLoading) {
        showLoading(context);
      } else if (next.hasError) {
        Navigator.of(context).pop();
        _handleResetPasswordError(next.error!, context);
      } else {
        if (next.value ?? false) {
          Navigator.of(context).pop();
          widget._onResetPasswordSucceed();
        }
      }
    });
  }

  _handleResetPasswordError(Object error, BuildContext context) {
    final strings = Strings.of(context);
    var errorTitle = strings.someThingWentWrongErrorDescription;
    var errorDesciption = strings.someThingWentWrongErrorDescription;

    if (error is AuthenticationError) {
      errorTitle = error.title(context);
      errorDesciption = error.description(context);
    }

    showErrorMessage(errorTitle, errorDesciption, context);
  }
}
