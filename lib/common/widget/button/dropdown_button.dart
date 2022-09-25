import 'package:aramex/app/theme.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomDropdownButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  const CustomDropdownButton({
    Key? key,
    required this.title,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Material(
      type: MaterialType.transparency,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.only(
            top: 10.hp,
            bottom: 10.hp,
            left: 16.wp,
            right: 10.wp,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.8,
              color: CustomTheme.gray.withOpacity(0.8),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: _textTheme.headline6,
              ),
              SizedBox(width: 8.wp),
              const Icon(
                Iconsax.arrow_down_1,
                size: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
