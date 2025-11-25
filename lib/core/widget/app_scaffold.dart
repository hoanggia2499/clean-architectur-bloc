import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget bodyPortrait;
  final Widget bodyLandScape;
  final Widget? bottomNavigationBar;
  const AppScaffold({
    super.key,
    required this.bodyPortrait,
    required this.bodyLandScape,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Hello ConvexAppBar')),
        body: OrientationBuilder(
          builder: (context, orientation) {
            switch (orientation) {
              case Orientation.portrait:
                return bodyPortrait;
              case Orientation.landscape:
                return bodyLandScape;
            }
          },
        ),
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
