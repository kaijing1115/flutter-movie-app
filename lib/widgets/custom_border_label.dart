import 'package:flutter/material.dart';
import '../autoload/autoloader.dart';

class CustomBorderLabel extends StatelessWidget {
  const CustomBorderLabel(
      {super.key,
      required this.label,
      this.onPressed,
      this.backgroundColor,
      this.icon,
      this.showIcon = true});

  final String label;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final IconData? icon;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: labelColor.withOpacity(0.6),
          ),
          borderRadius: BorderRadius.circular(15),
          color: backgroundColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: labelColor,
              ),
            ),
            const SizedBox(width: 10),
            if (showIcon)
              Icon(
                icon ?? Icons.expand_more,
                color: labelColor,
              ),
          ],
        ),
      ),
    );
  }
}
