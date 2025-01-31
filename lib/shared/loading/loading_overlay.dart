import 'package:flutter/material.dart';

mixin LoadingOverlay {
  OverlayEntry showLoadingOverlay(
    BuildContext context,
    OverlayEntry? overlayEntry,
  ) {
    ThemeData theme = Theme.of(context);

    overlayEntry = OverlayEntry(builder: ((context) {
      return Align(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.background),
        ),
      );
    }));

    final overlay = Overlay.of(context);
    overlay.insert(overlayEntry);

    return overlayEntry;
  }
}

class StatelessLoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const StatelessLoadingOverlay(
      {super.key, required this.isLoading, required this.child});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned(
            child: Container(
              color: Colors.black45,
              child: Center(
                child: CircularProgressIndicator(
                  color: theme.scaffoldBackgroundColor,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
