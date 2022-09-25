import 'package:aramex/app/theme.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool status;
  final String title;
  final ValueChanged<bool> onChanged;

  const CustomCheckbox({
    Key? key,
    required this.status,
    required this.title,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Container(
      child: InkWell(
        onTap: () {
          onChanged(!status);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: Checkbox(
                value: status,
                activeColor: _theme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                onChanged: (val) {
                  if (val != null) {
                    onChanged(val);
                  }
                },
              ),
            ),
            SizedBox(width: 10.wp),
            Text(
              title,
              style: _textTheme.headline6!.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
