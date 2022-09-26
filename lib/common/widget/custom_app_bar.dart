import 'package:aramex/app/theme.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:aramex/common/widget/button/custom_icon_button.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leadingIcon;
  final Widget? centerWidget;
  final List<Widget> actions;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;
  final Color? tabBackgroundColor;
  final String? title;
  final bool showBottomBorder;
  final Function()? onBackPressed;
  final bool showBackButton;
  final bool centerMiddle;
  final double? leftPadding;
  final double? rightPadding;
  final double topPadding;
  const CustomAppBar({
    Key? key,
    this.centerWidget,
    this.leadingIcon,
    this.bottom,
    this.backgroundColor,
    this.tabBackgroundColor,
    this.title,
    this.actions = const [],
    this.showBottomBorder = true,
    this.onBackPressed,
    this.centerMiddle = true,
    this.showBackButton = true,
    this.leftPadding,
    this.rightPadding,
    this.topPadding = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    final bool _canPop = Navigator.of(context).canPop();

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.only(
                left: leftPadding ?? CustomTheme.symmetricHozPadding.wp,
                right: rightPadding ?? CustomTheme.symmetricHozPadding.wp,
                top: MediaQuery.of(context).padding.top + topPadding,
              ),
              decoration: BoxDecoration(
                color: backgroundColor ?? _theme.scaffoldBackgroundColor,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 65),
                child: NavigationToolbar(
                  leading: leadingIcon != null
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [leadingIcon!],
                        )
                      : ((showBackButton && _canPop)
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomIconButton(
                                  icon: Icons.keyboard_arrow_left_rounded,
                                  onPressed: onBackPressed ??
                                      () {
                                        Navigator.of(context).maybePop();
                                      },
                                ),
                              ],
                            )
                          : null),
                  middle: title != null
                      ? Text(
                          title!,
                          style: _textTheme.headline4!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      : centerWidget,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: actions,
                  ),
                  centerMiddle: centerMiddle,
                  middleSpacing: NavigationToolbar.kMiddleSpacing,
                ),
              ),
            ),
          ),
          if (bottom != null)
            Container(
              color: tabBackgroundColor,
              child: bottom!,
            )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(160);
}
