import 'package:daily_quest/authentication/presentation/sign_in_notifier.dart';
import 'package:daily_quest/authentication/presentation/view/sign_in_button.dart';
import 'package:daily_quest/authentication/presentation/view/sign_in_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/strings.dart';

class SignInScreen extends ConsumerWidget {
  final VoidCallback onLoginSucceed;
  const SignInScreen({required this.onLoginSucceed, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final strings = Strings.of(context);
    final authProvider = ref.watch(signInStateProvider);
    return Center(
      child: authProvider.when(
        data: (isSignedIn) {
          if (isSignedIn) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              onLoginSucceed();
            });
            return const CircularProgressIndicator();
          } else {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                      SignInButton.email(
                          context: context,
                          onPressed: () {
                            final email = ref.read(signInEmailProvider);
                            final password = ref.read(signInPasswordProvicer);
                            ref
                                .read(signInStateProvider.notifier)
                                .signInWithEmail(
                                  email: email,
                                  password: password,
                                );
                          }),
                      const SizedBox(height: 20),
                      _orDivider(context),
                      const SizedBox(height: 20),
                      SignInButton.google(
                          context: context,
                          onPressed: () => ref
                              .read(signInStateProvider.notifier)
                              .signInWithGoogle()),
                      const SizedBox(height: 10),
                      SignInButton.guest(context: context, onPressed: () {}),
                      const SizedBox(height: 10),
                      _signUpButton(context),
                    ],
                  ),
                ],
              ),
            );
          }
        },
        error: (error, stackTrace) {
          return Text('Error: $error');
        },
        loading: () => const CircularProgressIndicator(),
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
}
