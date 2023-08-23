import 'package:flutter/material.dart';

import '../../../l10n/generated/l10n.dart';
import '../view/loading_indicator.dart';

showLoading(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const Center(child: LoadingIndicator());
    },
  );
}

showErrorMessage(
    String errorTitle, String errorDesciption, BuildContext context) {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(errorTitle),
        content: Text(errorDesciption),
        actions: <Widget>[
          TextButton(
            child: Text(Strings.of(context).dialogOkButtonTitle),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
