import 'package:daily_quest/authentication/presentation/helper/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/strings.dart';

final signInEmailProvider = StateProvider.autoDispose((ref) => '');
final signInPasswordProvicer = StateProvider.autoDispose((ref) => '');

class EmailLogin extends ConsumerStatefulWidget {
  const EmailLogin({super.key});

  @override
  EmailLoginState createState() => EmailLoginState();
}

class EmailLoginState extends ConsumerState<EmailLogin> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _shouldValidateEmail = false;
  bool get _isEmailValid {
    final email = _emailController.value.text;
    return !_shouldValidateEmail || EmailValidator.validate(email);
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StateController<String> email = ref.watch(signInEmailProvider.notifier);
    StateController<String> password =
        ref.watch(signInPasswordProvicer.notifier);
    final theme = Theme.of(context);
    final strings = Strings.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
          const SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              hintText: strings.passwordTextFieldHint,
              filled: false,
            ),
            controller: _passwordController,
            style: theme.textTheme.titleMedium,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            onChanged: (value) => password.state = value,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
