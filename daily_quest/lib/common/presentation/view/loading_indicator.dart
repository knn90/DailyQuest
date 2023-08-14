import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        decoration: BoxDecoration(
            color: theme.colorScheme.onBackground.withOpacity(0.2),
            borderRadius: const BorderRadius.all(Radius.circular(16))),
        padding: const EdgeInsets.all(32),
        child: const CircularProgressIndicator());
  }
}
