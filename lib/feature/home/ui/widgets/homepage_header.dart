import 'package:boilerplate/common/widget/button/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomePageHeader extends StatelessWidget {
  const HomePageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80",
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Good Morning",
                  style: _textTheme.headline6,
                ),
                const SizedBox(height: 2),
                Text(
                  "Sumit Kakshapati",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: _textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          CustomIconButton(
            icon: Iconsax.notification,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
