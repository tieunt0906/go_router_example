import 'package:flutter/material.dart' show BuildContext;

import 'generic_dialog.dart';

Future<void> showAuthError({
  required BuildContext context,
}) {
  return showGenericDialog<void>(
    context: context,
    title: 'Authentication error',
    content: 'Incorrect username and password',
    optionsBuilder: () => {
      'Ok': true,
    },
  );
}
