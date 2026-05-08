import 'package:flutter/material.dart';
import '../core/theme.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final bool isModeCard;
  final bool isFlameCard;
  final bool hasInnerShadow;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.borderRadius = 28,
    this.isModeCard = false,
    this.isFlameCard = false,
    this.hasInnerShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: isModeCard 
            ? AppTheme.modeCardGradient 
            : isFlameCard 
                ? const LinearGradient(
                    colors: [Color(0xFFE8EEDF), Color(0xBCFFFFFF)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  )
                : AppTheme.glassGradient,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: isModeCard 
              ? Colors.white.withValues(alpha: 0.16)
              : AppTheme.forest.withValues(alpha: 0.12),
          width: 1,
        ),
        boxShadow: [
          if (!isModeCard) ...[
            BoxShadow(
              color: AppTheme.pine.withValues(alpha: 0.10),
              blurRadius: 42,
              offset: const Offset(0, 18),
            ),
            if (hasInnerShadow)
              const BoxShadow(
                color: Color(0xBFFFFFFF),
                blurRadius: 0,
                offset: Offset(0, 1),
                blurStyle: BlurStyle.inner,
              ),
          ]
        ],
      ),
      child: child,
    );
  }
}
