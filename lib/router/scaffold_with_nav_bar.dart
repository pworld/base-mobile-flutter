import 'package:app_management_system/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../locale/app_localization.dart';

/// Builds the "shell" for the app by building a Scaffold with a
/// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
class ScaffoldWithNavBar extends StatelessWidget {
  /// Constructs an [ScaffoldWithNavBar].
  const ScaffoldWithNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor:
            Colors.black, // Color of the selected item's icon and label
        showSelectedLabels: true,
        unselectedItemColor: AppColors.richblack06,
        showUnselectedLabels: true,
        // Here, the items of BottomNavigationBar are hard coded. In a real
        // world scenario, the items would most likely be generated from the
        // branches of the shell route, which can be fetched using
        // `navigationShell.route.branches`.
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: const Icon(
                Icons.list_alt,
                color: AppColors.richblack06,
              ),
              activeIcon: const Icon(
                Icons.list_alt,
                color: Colors.black,
              ),
              label: AppLocalizations.of(context)!.translate('order')),
          // BottomNavigationBarItem(
          //     icon: const Icon(
          //       Icons.history_outlined,
          //       color: AppColors.richblack06,
          //     ),
          //     activeIcon: const Icon(
          //       Icons.history_outlined,
          //       color: Colors.black,
          //     ),
          //     label: AppLocalizations.of(context)!.translate('history')),
          BottomNavigationBarItem(
              icon: const Icon(
                Icons.person_2_outlined,
                color: AppColors.richblack06,
              ),
              activeIcon: const Icon(
                Icons.person_2_outlined,
                color: Colors.black,
              ),
              label: AppLocalizations.of(context)!.translate('profile')),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => _onTap(context, index),
      ),
    );
  }

  /// Navigate to the current location of the branch at the provided index when
  /// tapping an item in the BottomNavigationBar.
  void _onTap(BuildContext context, int index) {
    // When navigating to a new branch, it's recommended to use the goBranch
    // method, as doing so makes sure the last navigation state of the
    // Navigator for the branch is restored.
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
