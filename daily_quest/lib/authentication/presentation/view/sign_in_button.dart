import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../shared/images.dart';
import '../../../shared/strings.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,
    required this.title,
    this.icon,
    required this.onPressed,
  });
  final String title;
  final String? icon;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: _authenticationButtonStyle,
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
      title: Strings.of(context).signinGoogle,
      icon: Images.googleLogo,
      onPressed: onPressed,
    );
  }

  static SignInButton apple({
    required BuildContext context,
    required void Function() onPressed,
  }) {
    return SignInButton(
      title: Strings.of(context).signinApple,
      icon: Images.appleLogo,
      onPressed: onPressed,
    );
  }

  static SignInButton email({
    required BuildContext context,
    required void Function()? onPressed,
  }) {
    return SignInButton(
      title: Strings.of(context).signinEmail,
      onPressed: onPressed,
    );
  }

  static SignInButton signUp({
    required BuildContext context,
    required void Function()? onPressed,
  }) {
    return SignInButton(
      title: Strings.of(context).signup,
      onPressed: onPressed,
    );
  }

  static SignInButton guest({
    required BuildContext context,
    required void Function() onPressed,
  }) {
    return SignInButton(
      title: Strings.of(context).signinGuest,
      onPressed: onPressed,
    );
  }
}

final _authenticationButtonStyle = ElevatedButton.styleFrom(
  fixedSize: const Size(250, 48),
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
);
