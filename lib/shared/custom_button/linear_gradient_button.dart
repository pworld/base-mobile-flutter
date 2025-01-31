import 'package:app_management_system/theme/app_color.dart';
import 'package:flutter/material.dart';

class LinearGradientButton extends StatelessWidget {
  final String? prefixIcon;
  final String title;
  final double height;
  final double width;
  final Color color;
  final Function()? onTap;

  const LinearGradientButton(
      {super.key, this.prefixIcon,
      required this.title,
      this.height = 40,
      this.width = 60,
      this.color = AppColors.kSuccessColor,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width,
      width: height,
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
            colors: [AppColors.kGradientColor2, AppColors.kGradientColor3],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          splashColor: Colors.amber,
          onTap: () {
            onTap!();
          },
          child: Center(
              child: Text(title,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700))),
        ),
      ),
    );
  }
}
