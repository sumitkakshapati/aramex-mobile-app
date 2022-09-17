import 'package:boilerplate/app/theme.dart';
import 'package:flutter/material.dart';

class DashboardWidgets extends StatelessWidget {
  const DashboardWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      body: const Center(
        child: Text("Dashboard"),
      ),
    );
  }
}
