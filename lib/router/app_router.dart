import 'dart:developer';

import 'package:app_management_system/core/authentication/auth_provider.dart';
import 'package:app_management_system/feature/auth/presentation/screen/company_selection_screen.dart';
import 'package:app_management_system/feature/auth/presentation/screen/login_screen.dart';
import 'package:app_management_system/feature/auth/presentation/screen/otp_screen.dart';
import 'package:app_management_system/feature/orders/presentation/screen/order_list_screen.dart';
import 'package:app_management_system/feature/orders/presentation/screen/order_transfer_vehicle_screen.dart';
import 'package:app_management_system/feature/profile/presentation/pages/profile_screen.dart';
import 'package:app_management_system/router/scaffold_with_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum RouterPath {
  initial(path: '/'),

  // Authentication Screens
  login(path: '/login'),
  otp(path: '/otp'),
  companySelection(path: '/companySelection'),

  // Application Screens
  history(path: '/history'),
  profile(path: '/profile'),

  // Orders
  orders(path: '/orders'),
  orderTransfer(path: '/orderTransferVehicle'),
  ;

  const RouterPath({required this.path});
  final String path;

  static bool isGuestScreens(String path) {
    return (path == '/login' ||
        path == '/otp' ||
        path == '/companySelection' ||
        path == '/noCompany');
  }
}

final goRouterProvider = Provider<GoRouter>((ref) {
  var authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isLoggedIn = authState.isLoggedIn;
      final fullPath = state.fullPath ?? '';

      log('============================');
      log('LOGGED IN : ${isLoggedIn.toString()}');
      log('FULL PATH : $fullPath');
      log('============================');

      // If not logged in and inside authenticated screens
      if (!isLoggedIn && !RouterPath.isGuestScreens(fullPath)) {
        return '/login';
      }
      // If logged in and in guest screens
      else if (isLoggedIn && RouterPath.isGuestScreens(fullPath)) {
        return '/orders';
      }

      return null;
    },
    routes: [
      // Login Screen
      GoRoute(
        path: RouterPath.login.path,
        name: RouterPath.login.name,
        redirect: (_, __) async => null,
        pageBuilder: (context, state) => MaterialPage(
          child: LoginScreen(),
        ),
      ),

      // OTP Screen
      GoRoute(
        path: RouterPath.otp.path,
        name: RouterPath.otp.name,
        pageBuilder: (context, state) {
          // final otpResponse = state.extra as ResponseLoginFormModel;
          return MaterialPage(
            child: OTPScreen(),
          );
        },
      ),

      // Company Selection Screen
      GoRoute(
        path: RouterPath.companySelection.path,
        name: RouterPath.companySelection.name,
        pageBuilder: (context, state) => MaterialPage(child: CompanySelectionScreen())
      ),

      // Stack Navigation for Orders, History, and Profile
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          // Job Order ListScreen
          StatefulShellBranch(routes: [
            GoRoute(
              path: RouterPath.orders.path,
              name: RouterPath.orders.name,
              pageBuilder: (context, state) =>
                  const MaterialPage(child: OrderListScreen()),
            ),
          ]),

          // History Job Order Screen
          // StatefulShellBranch(routes: [
          //   GoRoute(
          //     path: RouterPath.history.path,
          //     name: RouterPath.history.name,
          //     pageBuilder: (context, state) =>
          //         const MaterialPage(child: JobOrderNewScreen()),
          //   ),
          // ]),

          // Profile Screen
          StatefulShellBranch(routes: [
            GoRoute(
              path: RouterPath.profile.path,
              name: RouterPath.profile.name,
              pageBuilder: (context, state) => MaterialPage(
                child: ProfileScreen(),
              ),
            ),
          ]),
        ],
      ),

      GoRoute(
        path: RouterPath.orderTransfer.path,
        name: RouterPath.orderTransfer.name,
        pageBuilder: (context, state) {
          final jobOrderId = state.extra is String
              ? state.extra as String
              : '0000-0000-00000000';
          return MaterialPage(
            child: OrderTransferVehicleDetailScreen(id: jobOrderId),
          );
        },
      ),

      // GoRoute(
      //   path: RouterPath.initial.path,
      //   name: RouterPath.initial.name,
      //   pageBuilder: (context, state) => MaterialPage(child: LoginScreen()),
      //   routes: [
      //     // Add the Login route here
      //     GoRoute(
      //       path: RouterPath.login.path,
      //       name: RouterPath.login.name,
      //       pageBuilder: (context, state) => MaterialPage(child: LoginScreen()),
      //     ),

      //     // Add the OTP route here
      //     GoRoute(
      //         path: RouterPath.loginDriver.path,
      //         name: RouterPath.loginDriver.name,
      //         pageBuilder: (context, state) {
      //           final otpResponse = state.extra as ResponseLoginFormModel;
      //           return MaterialPage(child: OTPScreen(otpResponse: otpResponse));
      //         }),

      //     // Add the Company route here
      //     GoRoute(
      //         path: RouterPath.loginCompany.path,
      //         name: RouterPath.loginCompany.name,
      //         // pageBuilder: (context, state) => MaterialPage(child: LoginCompanyScreen()),
      //         pageBuilder: (context, state) {
      //           final response = state.extra as ResponseAuthenticationModel;
      //           return MaterialPage(
      //               child: LoginCompanyScreen(authResponse: response));
      //         }),

      //     StatefulShellRoute.indexedStack(
      //       builder: (context, state, navigationShell) =>
      //           ScaffoldWithNavBar(navigationShell: navigationShell),
      //       branches: [
      //         StatefulShellBranch(routes: <RouteBase>[
      //           GoRoute(
      //               path: RouterPath.home.path,
      //               name: RouterPath.home.name,
      //               pageBuilder: (context, state) =>
      //                   const MaterialPage(child: JobOrderNewScreen())),
      //         ]),

      //         StatefulShellBranch(routes: <RouteBase>[
      //           GoRoute(
      //               path: RouterPath.jobOrder.path,
      //               name: RouterPath.jobOrder.name,
      //               pageBuilder: (context, state) =>
      //                   MaterialPage(child: HistoryJobOrderScreen())),
      //         ]),

      //         // Job Order History Not Exists For Now
      //         // StatefulShellBranch(routes: <RouteBase>[
      //         //   GoRoute(
      //         //       path: RouterPath.history.path,
      //         //       name: RouterPath.history.name,
      //         //       pageBuilder: (context, state) =>
      //         //           MaterialPage(child: JobOrderScreen())),
      //         // ]),

      //         StatefulShellBranch(routes: <RouteBase>[
      //           GoRoute(
      //               path: RouterPath.profile.path,
      //               name: RouterPath.profile.name,
      //               pageBuilder: (context, state) =>
      //                   MaterialPage(child: ProfileScreen())),
      //         ])
      //       ],
      //     ),

      //     GoRoute(
      //         path: RouterPath.transferVehicle.path,
      //         name: RouterPath.transferVehicle.name,
      //         pageBuilder: (context, state) {
      //           final jobOrderId = state.extra is String
      //               ? state.extra as String
      //               : 'defaultJobOrderId';
      //           return MaterialPage(
      //               child: TransferVehicleScreen(jobOrderId: jobOrderId));
      //         }),

      //     GoRoute(
      //         path: RouterPath.jodetail.path,
      //         name: RouterPath.jodetail.name,
      //         pageBuilder: (context, state) {
      //           final item = state.extra;
      //           return MaterialPage(child: JobOrderDetailScreen(joItem: item));
      //         }),

      //     GoRoute(
      //         path: RouterPath.maps.path,
      //         name: RouterPath.maps.name,
      //         pageBuilder: (context, state) {
      //           final item = state.extra;
      //           return MaterialPage(child: MapScreen(destloc: item));
      //         }),
      //   ],
      // ),
    ],
  );
});
