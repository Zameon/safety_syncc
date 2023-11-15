
import 'package:flutter/material.dart';

class CustomPageRoute<T> extends PageRouteBuilder<T> {
  @override
  final Widget Function(BuildContext, Animation<double>, Animation<double>) pageBuilder;

  CustomPageRoute({required this.pageBuilder})
      : super(
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
      return pageBuilder(context, animation, secondaryAnimation);
    },
    transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOutQuart;
      const duration = Duration(seconds: 1);

      var curveTween = CurveTween(curve: curve);
      var tween = Tween(begin: begin, end: end).chain(curveTween);

      var offsetAnimation = Tween(
        begin: tween.transform(0.0),
        end: tween.transform(1.0),
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Interval(0.0, 1.0, curve: curve),
        ),
      );

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}
