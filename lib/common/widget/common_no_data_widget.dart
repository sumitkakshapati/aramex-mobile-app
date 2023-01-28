import 'package:flutter/material.dart';

class CommonNoDataWidget extends StatelessWidget {
  final String message;
  final String? image;
  final double height;
  const CommonNoDataWidget({
    Key? key,
    required this.message,
    this.height = 160,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (image != null)
            Container(
              padding: const EdgeInsets.only(bottom: 20, top: 20),
              child: Image.asset(
                image!,
                height: height,
              ),
            ),
          Text(
            message,
            style: _textTheme.headline6!.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
