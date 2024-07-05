import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class CustomRouteTransition {
  static Widget sharedAxisVertical(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return SharedAxisTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      transitionType: SharedAxisTransitionType.vertical,
      child: child,
    );
  }

  static Widget sharedAxisHorizontal(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return SharedAxisTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      transitionType: SharedAxisTransitionType.horizontal,
      child: child,
    );
  }

  static Widget sharedAxisScaled(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return SharedAxisTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      transitionType: SharedAxisTransitionType.scaled,
      child: child,
    );
  }

  static Widget fadeThrough(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return FadeThroughTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      child: child,
    );
  }
}
