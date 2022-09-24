import 'package:boilerplate/common/util/size_utils.dart';
import 'package:boilerplate/common/widget/button/custom_icon_button.dart';
import 'package:flutter/material.dart';

class ProfileWidgets extends StatelessWidget {
  const ProfileWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: _theme.scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          CustomIconButton(
            icon: Icons.notifications,
            onPressed: () {},
          ),
          SizedBox(width: 16.wp),
        ],
      ),
    );
  }
}
