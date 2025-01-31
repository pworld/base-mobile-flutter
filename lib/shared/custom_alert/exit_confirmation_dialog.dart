import 'package:flutter/material.dart';

class ExitConfirmationDialog extends StatelessWidget {
  const ExitConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: buildChild(context),
    );
  }

  buildChild(BuildContext context) => Container();
}
