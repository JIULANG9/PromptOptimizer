import 'dart:ui';
import 'package:flutter/material.dart';

Future<T?> showAnimatedDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
  Duration transitionDuration = const Duration(milliseconds: 300),
}) {
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: Colors.transparent,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    transitionDuration: transitionDuration,
    pageBuilder:
        (
          BuildContext buildContext,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return builder(buildContext);
        },
    transitionBuilder:
        (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
            reverseCurve: Curves.easeInCubic,
          );

          final slideAnimation = Tween<Offset>(
            begin: const Offset(0, 0.1),
            end: Offset.zero,
          ).animate(curvedAnimation);

          final scaleAnimation = Tween<double>(
            begin: 0.6,
            end: 1.0,
          ).animate(curvedAnimation);

          return BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 4 * animation.value,
              sigmaY: 4 * animation.value,
            ),
            child: FadeTransition(
              opacity: curvedAnimation,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: SlideTransition(position: slideAnimation, child: child),
              ),
            ),
          );
        },
  );
}
