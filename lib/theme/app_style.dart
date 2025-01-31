import 'package:app_management_system/theme/app_color.dart';
import 'package:flutter/material.dart';

class AppStyle {
  static const EdgeInsets formPadding = EdgeInsets.all(16.0);
  static const InputDecoration inputDecoration = InputDecoration(
    border: OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.kPrimaryColor)),
    errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.kErrorColor)),
  );

  // Padding begin.
  static const kDefaultPadding = 16.0;

  static const kTextPadding = 4.0;
  // Padding end.

  // Screen width begin.
  static const kScreenWidthSm = 576.0;

  static const kScreenWidthMd = 768.0;

  static const kScreenWidthLg = 992.0;

  static const kScreenWidthXl = 1200.0;

  static const kScreenWidthXxl = 1400.0;
  // Screen width end.

  // Dialog width begin.
  static const kDialogWidth = 460.0;
  // Dialog width end.

  static const gapW2 = SizedBox(width: 2);
  static const gapW4 = SizedBox(width: 4);
  static const gapW8 = SizedBox(width: 8);
  static const gapW12 = SizedBox(width: 12);
  static const gapW14 = SizedBox(width: 14);
  static const gapW16 = SizedBox(width: 16);
  static const gapW18 = SizedBox(width: 18);
  static const gapW24 = SizedBox(width: 24);
  static const gapW28 = SizedBox(width: 28);
  static const gapW32 = SizedBox(width: 32);
  static const gapW48 = SizedBox(width: 48);
  static const gapW64 = SizedBox(width: 64);

  static const gapH2 = SizedBox(height: 2);
  static const gapH4 = SizedBox(height: 4);
  static const gapH8 = SizedBox(height: 8);
  static const gapH12 = SizedBox(height: 12);
  static const gapH14 = SizedBox(height: 14);
  static const gapH16 = SizedBox(height: 16);
  static const gapH18 = SizedBox(height: 18);
  static const gapH24 = SizedBox(height: 24);
  static const gapH28 = SizedBox(height: 28);
  static const gapH32 = SizedBox(height: 32);
  static const gapH48 = SizedBox(height: 48);
  static const gapH64 = SizedBox(height: 64);
}
