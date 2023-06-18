import 'package:aramex/app/theme.dart';
import 'package:aramex/common/widget/image/custom_network_image.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String description;
  final Widget? leading;
  final String image;
  final IconData? icon;
  final double titleFontSize;
  final FontWeight titleFontWeight;
  final Color titleColor;
  final double descriptionFontSize;
  final FontWeight descriptionFontWeight;
  final Color descriptionColor;
  final Color iconColor;
  final double topPadding;
  final double bottomPadding;
  final bool showBorder;
  final bool showNextIcon;
  final IconData? suffixIcon;
  final Color suffixColor;
  final VoidCallback? onPressed;
  final bool isAssetImage;
  CustomListTile({
    required this.title,
    this.description = "",
    this.image = "",
    this.leading,
    this.titleFontSize = 14,
    this.titleFontWeight = FontWeight.w400,
    this.titleColor = CustomTheme.lightTextColor,
    this.descriptionFontSize = 16,
    this.descriptionFontWeight = FontWeight.bold,
    this.descriptionColor = CustomTheme.gray,
    this.icon,
    this.iconColor = CustomTheme.primaryColor,
    this.bottomPadding = 14,
    this.topPadding = 14,
    this.showBorder = true,
    this.showNextIcon = false,
    this.suffixIcon,
    this.suffixColor = CustomTheme.gray,
    this.onPressed,
    this.isAssetImage = false,
  }) : assert(image.isEmpty || leading == null || icon == null);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.only(
          top: topPadding,
          bottom: bottomPadding,
        ),
        decoration: BoxDecoration(
          border: showBorder
              ? Border(
                  bottom: BorderSide(
                  color: CustomTheme.gray.withOpacity(0.4),
                  width: 1,
                ))
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (leading != null) leading!,
            if (image.isNotEmpty)
              switch (isAssetImage) {
                true => Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: iconColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      height: 30,
                      width: 30,
                      color: iconColor,
                    ),
                  ),
                false => CustomCachedNetworkImage(
                    url: image,
                    fit: BoxFit.cover,
                    height: 40,
                    width: 40,
                  )
              },
            if (icon != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                ),
              ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: _textTheme.headline6!.copyWith(
                      fontSize: titleFontSize,
                      color: titleColor,
                      fontWeight: titleFontWeight,
                    ),
                  ),
                  if (description.isNotEmpty) const SizedBox(height: 6),
                  if (description.isNotEmpty)
                    Text(
                      description,
                      style: _textTheme.headline6!.copyWith(
                        fontSize: descriptionFontSize,
                        color: descriptionColor,
                        fontWeight: descriptionFontWeight,
                      ),
                    ),
                ],
              ),
            ),
            if (showNextIcon || suffixIcon != null)
              Container(
                padding: const EdgeInsets.only(left: 12),
                child: Icon(
                  suffixIcon ?? Icons.keyboard_arrow_right_rounded,
                  size: 26,
                  color: suffixColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
