import 'package:daily_quest/authentication/presentation/view/sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/strings.dart';
import 'helper/email_validator.dart';

final resetPasswordEmailProvider = StateProvider.autoDispose((ref) => '');

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key});

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
    return Scaffold(
      appBar: AppBar(title: Text(strings.dailyQuest)),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(strings.resetPasswordTitle,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.5,
                )),
            const SizedBox(height: 10),
            const Text(
                'Enter the email address associated with your account and we\'ll send you a link to reset your password'),
            ValueListenableBuilder(
              valueListenable: _emailController,
              builder: (context, _, __) {
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
            Center(child: SignInButton(title: 'Continue', onPressed: () => {}))
          ],
        ),
      )),
    );
  }
}
