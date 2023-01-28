import 'package:aramex/app/theme.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DottedButton extends StatelessWidget {
  final String title;
  final String svgImagePath;
  final String imagePath;
  final Function onPressed;
  final double borderRadius;
  final bool isIconCentered;

  const DottedButton({
    required this.title,
    this.svgImagePath = "",
    required this.onPressed,
    this.imagePath = "",
    this.borderRadius = 24,
    this.isIconCentered = false,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Material(
      type: MaterialType.transparency,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: () => onPressed(),
        child: DottedBorder(
          borderType: BorderType.RRect,
          color: CustomTheme.lightGray.withOpacity(0.4),
          radius: Radius.circular(borderRadius),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            ),
            constraints: const BoxConstraints(minHeight: 45),
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
            child: Row(
              mainAxisAlignment: isIconCentered
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                if (svgImagePath.isNotEmpty)
                  SvgPicture.asset(
                    svgImagePath,
                    height: 20,
                    width: 20,
                    color: _theme.primaryColor,
                  ),
                if (imagePath.isNotEmpty)
                  Image.asset(
                    imagePath,
                    height: 20,
                    width: 20,
                    color: _theme.primaryColor,
                  ),
                if (imagePath.isNotEmpty || svgImagePath.isNotEmpty)
                  const SizedBox(width: 10),
                Flexible(
                  fit: FlexFit.tight,
                  flex: isIconCentered ? 0 : 1,
                  child: Text(
                    title,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: _textTheme.caption!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: CustomTheme.lightGray,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
