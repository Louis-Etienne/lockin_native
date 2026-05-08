import 'package:flutter/material.dart';
import '../core/theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final LinearGradient backgroundGradient;
  final Color textColor;
  final Color? borderColor;
  final List<BoxShadow>? boxShadow;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.backgroundGradient,
    required this.textColor,
    this.borderColor,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: backgroundGradient,
        borderRadius: BorderRadius.circular(19),
        border: borderColor != null ? Border.all(color: borderColor!, width: 1) : null,
        boxShadow: boxShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(19),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
            child: Center(
              child: Text(
                text,
                style: AppTheme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: textColor,
                  letterSpacing: -0.015 * 13.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const PrimaryButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      backgroundGradient: AppTheme.primaryButtonGradient,
      textColor: AppTheme.cream,
      boxShadow: [
        BoxShadow(
          color: AppTheme.emerald.withValues(alpha: 0.20),
          blurRadius: 28,
          offset: const Offset(0, 14),
        ),
      ],
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const SecondaryButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      backgroundGradient: AppTheme.secondaryButtonGradient,
      textColor: AppTheme.forest,
      borderColor: AppTheme.emerald.withValues(alpha: 0.16),
    );
  }
}

class DangerButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const DangerButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      backgroundGradient: AppTheme.dangerButtonGradient,
      textColor: Colors.white,
      boxShadow: [
        BoxShadow(
          color: AppTheme.danger.withValues(alpha: 0.18),
          blurRadius: 28,
          offset: const Offset(0, 14),
        ),
      ],
    );
  }
}

class PremiumButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const PremiumButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppTheme.premiumButtonGradient,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0x1A38422B), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1738422B),
            blurRadius: 26,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(22),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 17),
            child: Center(
              child: Text(
                text,
                style: AppTheme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                  color: AppTheme.pine,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
