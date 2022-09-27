import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/navigation/navigation_service.dart';
import 'package:aramex/common/widget/bottomsheet_wrapper.dart';
import 'package:aramex/common/widget/button/custom_icon_button.dart';
import 'package:aramex/common/widget/card/custom_list_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

showAccountActionsBottomSheet(
    {required BuildContext context, required VoidCallback onEditDetails}) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    builder: (context) {
      return _AccountActionsBottomsheet(
        onEditDetails: onEditDetails,
      );
    },
  );
}

class _AccountActionsBottomsheet extends StatelessWidget {
  final VoidCallback onEditDetails;
  const _AccountActionsBottomsheet({Key? key, required this.onEditDetails})
      : super(key: key);

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
                "Actions",
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
          CustomListTile(
            title: LocaleKeys.editDetails.tr(),
            bottomPadding: 16,
            topPadding: 16,
            leading: const Icon(
              Icons.edit,
              size: 18,
              color: CustomTheme.lightTextColor,
            ),
            onPressed: onEditDetails,
          ),
          CustomListTile(
            title: "Delete Account",
            bottomPadding: 16,
            topPadding: 16,
            leading: const Icon(
              Icons.delete,
              size: 18,
              color: CustomTheme.lightTextColor,
            ),
            showBorder: false,
            onPressed: () {
              NavigationService.pop();
            },
          ),
          SafeArea(child: Container()),
        ],
      ),
    );
  }
}
