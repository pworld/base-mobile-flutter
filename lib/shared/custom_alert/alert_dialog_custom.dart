import 'package:flutter/material.dart';

class AlertDialogCustom extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final bool isShowCancel;
  final Function()? onCancelClick;
  final Function()? onSubmitClick;

  const AlertDialogCustom(
      {super.key, required this.title,
      required this.message,
      this.confirmText = "Ok",
      this.cancelText = "Kembali",
      this.isShowCancel = true,
      this.onCancelClick,
      this.onSubmitClick});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        isShowCancel
            ? TextButton(
                child: Text(cancelText),
                onPressed: () {
                  onCancelClick!();
                },
              )
            : Container(),
        TextButton(
          child: Text(confirmText),
          onPressed: () {
            onSubmitClick!();
          },
        ),
      ],
    );
  }
}
