import 'package:boilerplate/common/constant/assets.dart';
import 'package:boilerplate/common/widget/image/custom_network_image.dart';
import 'package:flutter/material.dart';

class CustomRoundedImage extends StatelessWidget {
  final String image;
  final double height;
  final double width;
  final Widget? customPlaceHolder;
  final String fallBackImage;
  const CustomRoundedImage({
    Key? key,
    required this.height,
    required this.image,
    required this.width,
    this.customPlaceHolder,
    this.fallBackImage = Assets.fallbackImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height > width ? height : width),
      child: CustomCachedNetworkImage(
        url: image,
        height: height,
        width: width,
        fit: BoxFit.cover,
        alignment: Alignment.center,
        customPlaceHolder: customPlaceHolder,
        placeholder: fallBackImage,
      ),
    );
  }
}
