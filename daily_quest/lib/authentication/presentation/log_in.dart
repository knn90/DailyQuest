import 'package:daily_quest/authentication/presentation/log_in_notifier.dart';
import 'package:daily_quest/daily_quest/presentation/today_quest/today_quest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../shared/images.dart';
import '../../shared/strings.dart';

class LoginOption extends ConsumerWidget {
  const LoginOption({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final strings = Strings.of(context);
    final authProvider = ref.watch(loginProvider);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: authProvider.when(
            data: (isLoggedIn) {
              if (isLoggedIn) {
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const TodayQuest(),
                    ),
                  );
                });
              }
              return SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 5),
                      child: Text(strings.signin,
                          style: theme.textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold)),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const EmailLogin(),
                        SignInButton.email(context: context, onPressed: () {}),
                        const SizedBox(height: 20),
                        _orDivider(context),
                        const SizedBox(height: 20),
                        SignInButton.google(
                          context: context,
                          onPressed: () {
                            ref.read(loginProvider.notifier).signInWithGoogle();
                          },
                        ),
                        const SizedBox(height: 10),
                        SignInButton.apple(context: context, onPressed: () {}),
                        const SizedBox(height: 10),
                        SignInButton.guest(context: context, onPressed: () {}),
                        const SizedBox(height: 10),
                        _signUpButton(context),
                      ],
                    ),
                  ],
                ),
              );
            },
            error: (error, stackTrace) {
              return Text('Error: $error');
            },
            loading: () => const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
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
          child: Divider(
            color: color,
            indent: 10,
          ),
        ),
      ],
    ),
  );
}

OutlinedButton _signUpButton(BuildContext context) {
  final strings = Strings.of(context);
  return OutlinedButton(
    onPressed: () {},
    style: OutlinedButton.styleFrom(
      fixedSize: const Size(250, 48),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    ),
    child: Text(strings.signup),
  );
}

class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,
    required this.title,
    this.icon,
    required this.onPressed,
  });
  final String title;
  final String? icon;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(250, 48),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15)),
      child: icon != null
          ? Row(children: [
              SvgPicture.asset(icon!),
              const SizedBox(width: 20),
              Text(title)
            ])
          : Text(title),
    );
  }

  static SignInButton google({
    required BuildContext context,
    required void Function() onPressed,
  }) {
    return SignInButton(
      title: Strings.of(context).signin_google,
      icon: Images.googleLogo,
      onPressed: onPressed,
    );
  }

  static SignInButton apple({
    required BuildContext context,
    required void Function() onPressed,
  }) {
    return SignInButton(
      title: Strings.of(context).signin_apple,
      icon: Images.appleLogo,
      onPressed: onPressed,
    );
  }

  static SignInButton email({
    required BuildContext context,
    required void Function() onPressed,
  }) {
    return SignInButton(
      title: Strings.of(context).signin_email,
      onPressed: onPressed,
    );
  }

  static SignInButton guest({
    required BuildContext context,
    required void Function() onPressed,
  }) {
    return SignInButton(
      title: Strings.of(context).signin_guest,
      onPressed: onPressed,
    );
  }
}

final loginEmailProvider = StateProvider.autoDispose((ref) => '');
final loginPasswordProvicer = StateProvider.autoDispose((ref) => '');

class EmailLogin extends ConsumerStatefulWidget {
  const EmailLogin({super.key});

  @override
  EmailLoginState createState() => EmailLoginState();
}

class EmailLoginState extends ConsumerState<EmailLogin> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

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
    StateController<String> email = ref.watch(loginEmailProvider.notifier);
    StateController<String> password =
        ref.watch(loginPasswordProvicer.notifier);
    final theme = Theme.of(context);
    final strings = Strings.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: strings.emailTextFieldHint,
              filled: false,
            ),
            controller: _emailController,
            style: theme.textTheme.titleMedium,
            autofocus: true,
            maxLines: 1,
            onChanged: (value) {
              email.state = value;
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
