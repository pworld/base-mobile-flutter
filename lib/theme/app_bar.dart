import 'package:flutter/material.dart';

import 'app_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color backgroundColor = isDarkMode ? Theme.of(context).colorScheme.primary : Theme.of(context).primaryColor;

    return AppBar(
      backgroundColor: backgroundColor, // Dynamically set based on theme
      elevation: 10,
      shadowColor: Colors.black45,
      title: Text(title, style: AppText.heading1.copyWith(color: Theme.of(context).colorScheme.onPrimary)), // Text color based on theme
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onPrimary),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.settings, color: Theme.of(context).colorScheme.onPrimary),
          onPressed: () {
            // handle settings action
          },
        ),
      ],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)
          )
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}
