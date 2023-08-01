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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            EmailLogin(),
            ElevatedButton(
                onPressed: () {},
                child: const Text('Continue with email'),
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(250, 48),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15))),
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
                Text('or'),
                Expanded(
                  child: Divider(
                    color: theme.colorScheme.onPrimaryContainer,
                    indent: 10,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SignInButton.google(onPress: () {}),
            const SizedBox(height: 10),
            SignInButton.apple(onPress: () {})
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
    required this.icon,
    required this.onPressed,
  });
  final String title;
  final String icon;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(250, 48),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15)),
      child: Row(
        children: [
          SvgPicture.asset(icon),
          const SizedBox(width: 20),
          Text(title)
        ],
      ),
    );
  }

  static SignInButton google({required Function onPress}) {
    return SignInButton(
      title: 'Sign in with Google',
      icon: 'assets/images/google-logo.svg',
      onPressed: onPress,
    );
  }

  static SignInButton apple({required Function onPress}) {
    return SignInButton(
      title: 'Sign in with Apple',
      icon: 'assets/images/apple-logo.svg',
      onPressed: onPress,
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
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(
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
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              hintText: 'Password',
              filled: false,
            ),
            controller: _passwordController,
            style: theme.textTheme.bodyMedium,
            onChanged: (value) => password.state = value,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
