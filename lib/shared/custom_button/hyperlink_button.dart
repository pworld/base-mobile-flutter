import 'package:app_management_system/theme/app_color.dart';
import 'package:flutter/material.dart';

class HyperlinkButton extends StatelessWidget {
  final Widget? prefixIcon;
  final String title;
  final double fontSize;
  final double height;
  final double width;
  final Color color;
  final bool underline;
  final Function()? onTap;

  const HyperlinkButton(
      {super.key,
      this.prefixIcon,
      required this.title,
      this.fontSize = 14,
      this.height = 40,
      this.width = 80,
      this.color = AppColors.kPrimaryColor,
      this.underline = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            onTap!();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (prefixIcon != null)
                Padding(
                    padding: const EdgeInsets.only(right: 1),
                    child: prefixIcon),
              Align(
                alignment: Alignment.center,
                child: Text(title,
                    style: TextStyle(
                      fontSize: fontSize,
                      color: color,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
