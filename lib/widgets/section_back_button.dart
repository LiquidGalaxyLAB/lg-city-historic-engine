import 'package:flutter/material.dart';

import '../navigation/app_navigation.dart';

/// Back button; goes home if there is no previous route.
class SectionBackButton extends StatelessWidget {
  const SectionBackButton({
    super.key,
    this.onDarkBackground = false,
    this.icon = Icons.arrow_back_ios_new,
    this.iconSize = 22,
    this.onPressed,
  });

  final bool onDarkBackground;
  final IconData icon;
  final double iconSize;
  final VoidCallback? onPressed;

  void _handleBack(BuildContext context) {
    if (onPressed != null) {
      onPressed!();
      return;
    }
    AppNavigation.popOrHome(context);
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = onDarkBackground
        ? Colors.white
        : Theme.of(context).colorScheme.onSurface;

    return IconButton(
      onPressed: () => _handleBack(context),
      icon: Icon(icon, color: iconColor, size: iconSize),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
      style: IconButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: onDarkBackground
            ? Colors.black.withValues(alpha: 0.2)
            : Colors.transparent,
      ),
    );
  }
}
