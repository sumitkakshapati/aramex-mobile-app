import 'package:aramex/app/theme.dart';
import 'package:aramex/common/navigation/navigation_service.dart';
import 'package:aramex/common/widget/bottomsheet_wrapper.dart';
import 'package:aramex/common/widget/button/custom_icon_button.dart';
import 'package:aramex/common/widget/card/custom_list_tile.dart';
import 'package:flutter/material.dart';

showOptionsBottomSheet({
  required List<String> options,
  required ValueChanged onChanged,
  required String label,
  required BuildContext context,
}) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    builder: (context) {
      return _OptionsBottomsheet(
        options: options,
        onChanged: onChanged,
        label: label,
      );
    },
  );
}

class _OptionsBottomsheet extends StatelessWidget {
  final List<String> options;
  final ValueChanged onChanged;
  final String label;

  const _OptionsBottomsheet({
    Key? key,
    required this.options,
    required this.onChanged,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return BottomSheetWrapper(
      widgetSpacing: 10,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                label,
                style: _textTheme.headline3,
              ),
              const Spacer(),
              CustomIconButton(
                icon: Icons.close,
                backgroundColor: CustomTheme.gray.withOpacity(0.4),
                onPressed: () {
                  NavigationService.pop();
                },
              )
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  options.length,
                  (index) {
                    return CustomListTile(
                      title: options[index],
                      bottomPadding: 16,
                      topPadding: 16,
                      onPressed: () {
                        onChanged(options[index]);
                        NavigationService.pop();
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          // ...List.generate(
          //   options.length,
          //   (index) {
          //     return CustomListTile(
          //       title: options[index],
          //       bottomPadding: 16,
          //       topPadding: 16,
          //       onPressed: () {
          //         onChanged(options[index]);
          //         NavigationService.pop();
          //       },
          //     );
          //   },
          // ),
          SafeArea(child: Container()),
        ],
      ),
    );
  }
}
