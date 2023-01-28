import 'package:aramex/common/constant/assets.dart';
import 'package:aramex/common/util/text_utils.dart';
import 'package:aramex/common/widget/button/custom_icon_button.dart';
import 'package:aramex/common/widget/image/custom_network_image.dart';
import 'package:aramex/feature/authentication/model/user.dart';
import 'package:aramex/feature/authentication/resource/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class HomePageHeader extends StatelessWidget {
  const HomePageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _userRepository = RepositoryProvider.of<UserRepository>(context);

    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top + 20),
      child: ValueListenableBuilder<User?>(
          valueListenable: _userRepository.user,
          builder: (context, user, _) {
            return Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CustomCachedNetworkImage(
                    url: user?.photo?.path ?? "",
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                    placeholder: Assets.user,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        TextUtils.generateGreet,
                        style: _textTheme.headline6,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        user?.fullname.capitalize() ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: _textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // const SizedBox(width: 12),
                // CustomIconButton(
                //   icon: Iconsax.notification,
                //   onPressed: () {},
                // ),
              ],
            );
          }),
    );
  }
}
