import 'package:aramex/app/theme.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:flutter/material.dart';

class BottomSheetWrapper extends StatelessWidget {
  final EdgeInsets? padding;
  final double? topPadding;
  final Widget child;
  final bool showTopDivider;
  final int widgetSpacing;
  final String? title;
  const BottomSheetWrapper({
    this.padding,
    this.topPadding,
    this.showTopDivider = true,
    this.widgetSpacing = 24,
    this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(36),
      ),
      child: Container(
        padding: padding ??
            EdgeInsets.only(
              left: CustomTheme.symmetricHozPadding,
              right: CustomTheme.symmetricHozPadding,
              top: 30.hp,
              bottom: 10.hp,
            ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(36),
          ),
          color: _theme.scaffoldBackgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null)
              Text(
                title!,
                style: _theme.textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (showTopDivider)
              Container(
                height: 4,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: CustomTheme.lightGray,
                ),
              ),
            SizedBox(height: widgetSpacing.hp),
            child,
          ],
        ),
      ),
    );
  }
}
