import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/navigation/navigation_service.dart';
import 'package:aramex/common/util/form_validator.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:aramex/common/util/snackbar_utils.dart';
import 'package:aramex/common/widget/button/custom_outline_button.dart';
import 'package:aramex/common/widget/button/rounded_button.dart';
import 'package:aramex/common/widget/custom_app_bar.dart';
import 'package:aramex/common/widget/options_bottomsheet.dart';
import 'package:aramex/common/widget/text_field/custom_textfield.dart';
import 'package:aramex/feature/account_payment/model/user_wallet.dart';
import 'package:aramex/feature/account_payment/model/wallet.dart';
import 'package:aramex/feature/request_pay/cubit/save_wallet_cubit.dart';
import 'package:aramex/feature/request_pay/cubit/wallet_list_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

class AddWalletDetailsWidgets extends StatefulWidget {
  const AddWalletDetailsWidgets({Key? key}) : super(key: key);

  @override
  State<AddWalletDetailsWidgets> createState() =>
      _AddWalletDetailsWidgetsState();
}

class _AddWalletDetailsWidgetsState extends State<AddWalletDetailsWidgets> {
  final ValueNotifier<List<Wallet>> _wallets = ValueNotifier([]);
  final TextEditingController _walletController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  int? _selectedWalletId;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    context.read<WalletListCubit>().fetchWallets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: MultiBlocListener(
          listeners: [
            BlocListener<WalletListCubit, CommonState>(
              listener: (context, state) {
                if (state is CommonDataFetchedState<Wallet>) {
                  _wallets.value = state.data;
                }
              },
            ),
            BlocListener<SaveWalletCubit, CommonState>(
              listener: (context, state) {
                if (state is CommonLoadingState) {
                  setState(() {
                    _isLoading = true;
                  });
                } else {
                  setState(() {
                    _isLoading = false;
                  });
                }

                if (state is CommonDataSuccessState<UserWallet>) {
                  SnackBarUtils.showSuccessBar(
                    context: context,
                    message: "Wallet saved successfully",
                  );
                  NavigationService.pop();
                } else if (state is CommonErrorState) {
                  SnackBarUtils.showErrorBar(
                    context: context,
                    message: state.message,
                  );
                }
              },
            ),
          ],
          child: Form(
            key: _formkey,
            child: Container(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.only(top: 20.hp),
                      padding: const EdgeInsets.symmetric(
                          horizontal: CustomTheme.symmetricHozPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocaleKeys.addWalletDetails.tr(),
                            style: _textTheme.headline3!.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 16.hp),
                          ValueListenableBuilder<List<Wallet>>(
                            valueListenable: _wallets,
                            builder: (context, wallets, _) {
                              return CustomTextField(
                                label: LocaleKeys.selectWallet.tr(),
                                hintText: "Esewa",
                                readOnly: true,
                                suffixIcon: Icons.keyboard_arrow_down_rounded,
                                controller: _walletController,
                                validator: (val) {
                                  return FormValidator.validateFieldNotEmpty(
                                    val,
                                    LocaleKeys.wallets.tr(),
                                  );
                                },
                                onPressed: () {
                                  showOptionsBottomSheet(
                                    label: LocaleKeys.wallets.tr(),
                                    options:
                                        wallets.map((e) => e.name).toList(),
                                    onChanged: (val) {
                                      _walletController.text = val;
                                      _selectedWalletId = wallets
                                          .firstWhere((e) => e.name == val)
                                          .id;
                                    },
                                    context: context,
                                  );
                                },
                              );
                            },
                          ),
                          CustomTextField(
                            label: LocaleKeys.walletID.tr(),
                            hintText: "eg. Sumit Kakshapati",
                            controller: _usernameController,
                            validator: (val) {
                              return FormValidator.validateFieldNotEmpty(
                                val,
                                LocaleKeys.walletID.tr(),
                              );
                            },
                          ),
                          SizedBox(height: 20.hp),
                        ],
                      ),
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: CustomTheme.symmetricHozPadding,
                            ),
                            color: Colors.white,
                            child: Row(
                              children: [
                                Expanded(
                                  child: CustomOutlineButton(
                                    title: LocaleKeys.cancel.tr(),
                                    onPressed: () {
                                      NavigationService.pop();
                                    },
                                  ),
                                ),
                                SizedBox(width: 20.wp),
                                Expanded(
                                  child: CustomRoundedButtom(
                                    title: "Save Account",
                                    onPressed: () {
                                      if (_formkey.currentState!.validate()) {
                                        context
                                            .read<SaveWalletCubit>()
                                            .saveWallet(
                                              username:
                                                  _usernameController.text,
                                              walletId: _selectedWalletId!,
                                            );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
