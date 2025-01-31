import 'package:app_management_system/core/authentication/auth_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authProvider = ChangeNotifierProvider((ref) {
  AuthController authController = AuthController();
  authController.init();
  return authController;
});
