import 'package:flutter/material.dart';


class DashBoardBody extends StatelessWidget {
  final int index;
  const DashBoardBody({super.key, required this.index});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Text('Page not found: $index'),
      ),
    );
  }
}
