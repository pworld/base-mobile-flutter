import 'package:app_management_system/theme/app_color.dart';
import 'package:app_management_system/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  const LogoutConfirmationDialog({
    super.key,
    this.onCancelClick,
    this.onSubmitClick,
  });

  final VoidCallback? onCancelClick;
  final VoidCallback? onSubmitClick;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(  // Use Expanded here to make sure the text fits within the row
                  child: Text(
                    "APAKAH ANDA YAKIN INGIN KELUAR?",
                    style: AppText.textField,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Anda akan keluar dari aplikasi.',
              textAlign: TextAlign.center,
              style: AppText.textField,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  context,
                  label: "Ya",
                  onTap: onSubmitClick,
                  color: AppColors.raspberry01,
                  textColor: AppColors.raspberry04,
                ),
                _buildActionButton(
                  context,
                  label: "Batal",
                  onTap: onCancelClick ?? () => Navigator.of(context).pop(),
                  color: AppColors.ultramarine00,
                  textColor: AppColors.ultramarine05,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
      BuildContext context, {
        required String label,
        VoidCallback? onTap,
        required Color color,
        required Color textColor,
      }) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
