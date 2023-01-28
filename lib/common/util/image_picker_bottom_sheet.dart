import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/assets.dart';
import 'package:aramex/common/widget/button/dotted_button.dart';
import 'package:flutter/material.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  final Function onGalleryPressed;
  final Function? onCameraPressed;
  final bool? showCameraOption;

  const ImagePickerBottomSheet({
    this.onCameraPressed,
    required this.onGalleryPressed,
    this.showCameraOption = true,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -2),
            color: Colors.grey.withOpacity(0.07),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 24, bottom: 24),
            height: 4,
            width: 55,
            decoration: BoxDecoration(
              color: CustomTheme.lightGray.withOpacity(0.4),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Text(
            "Upload a Photo",
            style: _textTheme.headline6!.copyWith(
              color: CustomTheme.lightGray,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 43),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: DottedButton(
                    title: "Select a Gallery",
                    svgImagePath: Assets.gallerySVG,
                    onPressed: () => onGalleryPressed(),
                  ),
                ),
                if (showCameraOption!) const SizedBox(width: 20),
                if (showCameraOption!)
                  Expanded(
                    child: DottedButton(
                      title: "Take a Picture",
                      svgImagePath: Assets.cameraSvg,
                      onPressed: () => onCameraPressed!(),
                    ),
                  )
              ],
            ),
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
