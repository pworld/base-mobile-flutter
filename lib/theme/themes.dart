import 'package:app_management_system/theme/app_button_theme.dart';
import 'package:app_management_system/theme/app_color_scheme.dart';
import 'package:flutter/material.dart';

class AppThemeData {
  AppThemeData._();

  static final AppThemeData _instance = AppThemeData._();

  static AppThemeData get instance => _instance;

  ThemeData light() {
    // Updated primary color for a more modern and softer look
    const Color updatedPrimaryColor = Color(0xFF5C6BC0); // Example: Soft Blue
    const Color updatedSecondaryColor = Color(0xFFEC407A); // Example: Soft Pink

    final themeData = ThemeData(
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: updatedPrimaryColor, // Use updatedPrimaryColor
        foregroundColor: Colors.white,
      ),
      scaffoldBackgroundColor: Colors.white, // Brighter background for better readability
      drawerTheme: const DrawerThemeData(backgroundColor: Color(0xFFF0F0F0)), // Lighter drawer background
      colorScheme: const ColorScheme.light(
        primary: updatedPrimaryColor,
        onPrimary: Colors.white,
        secondary: updatedSecondaryColor,
        onSecondary: Colors.white,
        error: Colors.redAccent, // Darker text for better readability
        surface: Colors.white,
        onSurface: Colors.black87,
      ),
      cardTheme: const CardTheme(
        margin: EdgeInsets.zero,
        color: Color(0xFFF5F5F5), // Light grey background for cards for subtle contrast
      ),
    );

    final appColorScheme = AppColorScheme(
      primary: updatedPrimaryColor,
      secondary: updatedSecondaryColor,
      error: Colors.redAccent,
      success: Colors.greenAccent[400] ?? Colors.greenAccent, // Consider a softer shade for success
      info: const Color(0xFF64B5F6), // Softer blue for information
      warning: const Color(0xFFFFD54F), // Soft yellow for warnings
      hyperlink: const Color(0xFF1565C0), // Clear blue for hyperlinks
      buttonTextBlack: Colors.black87, // Darker text for better readability
      buttonTextDisabled: Colors.black26, // Disabled text should be less opaque for better distinction
    );

    return themeData.copyWith(
      textTheme: themeData.textTheme.apply(
        bodyColor: Colors.black87,
        displayColor: Colors.black87,
      ),
      extensions: [
        AppButtonTheme.fromAppColorScheme(appColorScheme),
        appColorScheme,
      ],
    );
  }

  ThemeData dark() {
    // Updated primary and secondary colors for a visually appealing dark theme
    const Color updatedPrimaryColor = Color(0xFF7986CB); // Example: Soft Indigo
    const Color updatedSecondaryColor = Color(0xFFEF9A9A); // Example: Soft Red

    final themeData = ThemeData.dark().copyWith(
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: updatedPrimaryColor, // Use updatedPrimaryColor for consistency
        foregroundColor: Colors.white,
      ),
      scaffoldBackgroundColor: const Color(0xFF121212), // Darker background for true dark mode experience
      drawerTheme: const DrawerThemeData(backgroundColor: Color(0xFF1E1E1E)), // Slightly lighter shade for drawer background
      cardTheme: const CardTheme(
        margin: EdgeInsets.zero,
        color: Color(0xFF1E1E1E), // Consistent with drawer background for uniformity
      ),
      colorScheme: ColorScheme.dark(
        primary: updatedPrimaryColor,
        onPrimary: Colors.white,
        secondary: updatedSecondaryColor,
        onSecondary: Colors.white,
        error: Colors.redAccent[700] ?? Colors.redAccent, // Soft white for general text to reduce glare
        surface: const Color(0xFF1E1E1E),
        onSurface: Colors.white70,
      ),
    );

    final appColorScheme = AppColorScheme(
      primary: updatedPrimaryColor,
      secondary: updatedSecondaryColor,
      error: Colors.redAccent[700] ?? Colors.redAccent,
      success: Colors.greenAccent[700] ?? Colors.greenAccent, // Softer green for success messages
      info: const Color(0xFF64B5F6), // Maintaining a soft blue for info to ensure visibility
      warning: const Color(0xFFFFD54F), // Keeping warning color bright for attention but not too stark
      hyperlink: const Color(0xFF82B1FF), // Softer blue for hyperlinks to reduce glare
      buttonTextBlack: Colors.white70, // Soft white for button text for readability
      buttonTextDisabled: Colors.white30, // Even softer white for disabled state for contrast
    );

    return themeData.copyWith(
      textTheme: themeData.textTheme.apply(
        bodyColor: Colors.grey[700]!,
        displayColor: Colors.grey[700]!,
      ),
      inputDecorationTheme: InputDecorationTheme(
        // Define the border styles
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[300]!), // Light grey border for enabled state
          borderRadius: BorderRadius.circular(4.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[500]!), // Darker grey border for focused state
          borderRadius: BorderRadius.circular(4.0),
        ),
        // Define the label, hint, and text styles
        labelStyle: TextStyle(color: Colors.grey[600]), // Grey label text
        hintStyle: TextStyle(color: Colors.grey[500]), // Grey hint text
        // You can adjust more properties as needed
      ),
      extensions: [
        AppButtonTheme.fromAppColorScheme(appColorScheme),
        appColorScheme,
      ],
    );
  }
}