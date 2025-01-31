import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

FutureOr<String?> appRouteRedirect(
    BuildContext context, Ref ref, GoRouterState state) async {
  // final authData = ref.watch(loginNotifierProvider);
  // final loggedIn = authData?.loginEntity != null;
  // final loggedOut = authData?.loginEntity == null;
  // final loggingIn = state.matchedLocation == '/';

  // if (loggedOut) return '/';

  // if (loggingIn && loggedIn && authData?.loginEntity?.token != null) {
  //   return '/${RouterPath.dashboard.path}';
  // }
  return null;
}
