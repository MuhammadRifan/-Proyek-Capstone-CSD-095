import 'package:flutter/material.dart';

class CustomScrollBehavior extends StatelessWidget {
  const CustomScrollBehavior({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: CustomBehavior(),
      child: child,
    );
  }
}

class CustomBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(context, child, axisDirection) {
    return child;
  }
}
