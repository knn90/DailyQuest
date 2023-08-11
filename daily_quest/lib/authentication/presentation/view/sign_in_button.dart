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
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: authenticationButtonStyle,
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

final authenticationButtonStyle = ElevatedButton.styleFrom(
  fixedSize: const Size(250, 48),
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
);
