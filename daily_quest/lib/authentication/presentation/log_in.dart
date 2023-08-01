import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class LoginOption extends StatelessWidget {
  const LoginOption({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 5),
              child: Text("Sign in",
                  style: theme.textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const EmailLogin(),
                SignInButton.email(onPressed: () {}),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        color: theme.colorScheme.onPrimaryContainer,
                        endIndent: 10,
                      ),
                    ),
                    const Text('or'),
                    Expanded(
                      child: Divider(
                        color: theme.colorScheme.onPrimaryContainer,
                        indent: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SignInButton.google(onPressed: () {}),
                const SizedBox(height: 10),
                SignInButton.apple(onPressed: () {}),
                const SizedBox(height: 10),
                SignInButton.guest(onPressed: () {}),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(250, 48),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                  ),
                  child: const Text('Sign up'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
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
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
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

  static SignInButton google({required Function onPressed}) {
    return SignInButton(
      title: 'Sign in with Google',
      icon: 'assets/images/google-logo.svg',
      onPressed: onPressed,
    );
  }

  static SignInButton apple({required Function onPressed}) {
    return SignInButton(
      title: 'Sign in with Apple',
      icon: 'assets/images/apple-logo.svg',
      onPressed: onPressed,
    );
  }

  static SignInButton email({required Function onPressed}) {
    return SignInButton(title: 'Continue with email', onPressed: onPressed);
  }

  static SignInButton guest({required Function onPressed}) {
    return SignInButton(title: 'Continue as a Guest', onPressed: onPressed);
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Email',
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
            decoration: const InputDecoration(
              hintText: 'Password',
              filled: false,
            ),
            controller: _passwordController,
            style: theme.textTheme.titleMedium,
            onChanged: (value) => password.state = value,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
