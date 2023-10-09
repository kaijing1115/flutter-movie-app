import 'package:flutter/material.dart';
import '../autoload/autoloader.dart';

class CustomFilledTextButton extends StatelessWidget {
  const CustomFilledTextButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.backgroundColor,
      this.textColor});

  final VoidCallback onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? buttonBackgroundColor,
        foregroundColor: textColor ?? buttonForegroundColor,
        minimumSize: Size(70, 35),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}

class RoundedIconButton extends StatelessWidget {
  const RoundedIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor.withOpacity(0.6),
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.all(5),
        child: Icon(
          icon,
          size: 16,
        ),
      ),
    );
  }
}
