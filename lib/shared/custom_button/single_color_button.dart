import 'package:app_management_system/theme/app_color.dart';
import 'package:flutter/material.dart';

class SingleColorButton extends StatelessWidget {
  final Widget? prefixIcon;
  final String title;
  final double height;
  final double width;
  final Color color;
  final Color textColor;
  final Function()? onTap;

  const SingleColorButton({
    super.key,
    this.prefixIcon,
    required this.title,
    this.height = 40,
    this.width = 80,
    this.color = AppColors.kSuccessColor, // Ensure AppColors.kSuccessColor is a constant
    this.textColor = AppColors.white, // Ensure AppColors.white is a constant
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          splashColor: Colors.amber,
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (prefixIcon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8), // Adjusted right padding
                  child: prefixIcon,
                ),
              Text(
                title,
                style: TextStyle( // Removed const
                  color: textColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

