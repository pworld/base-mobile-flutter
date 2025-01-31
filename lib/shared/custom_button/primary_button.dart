import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Function()? onPress;
  final bool? disabled;
  final String text;

  const PrimaryButton({
    super.key,
    this.onPress,
    this.disabled,
    required this.text,
  });

  void handleTap() {
    if (!isDisabled()) {
      onPress?.call();
    }
  }

  bool isDisabled() {
    return disabled ?? false;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool disabled = isDisabled();

    return Material(
      color: disabled
          ? theme.colorScheme.surfaceVariant
          : theme.colorScheme.primary,
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      child: InkWell(
        splashColor: disabled ? Colors.transparent : theme.splashColor,
        hoverColor: disabled ? Colors.transparent : theme.hoverColor,
        highlightColor: disabled ? Colors.transparent : theme.highlightColor,
        focusColor: disabled ? Colors.transparent : theme.focusColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        onTap: handleTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabled
                  ? theme.colorScheme.onBackground
                  : theme.colorScheme.inversePrimary,
            ),
          ),
        ),
      ),
    );
  }
}
