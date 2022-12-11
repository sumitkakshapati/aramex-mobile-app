import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/navigation/navigation_service.dart';
import 'package:aramex/common/util/form_validator.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:aramex/common/util/snackbar_utils.dart';
import 'package:aramex/common/widget/button/custom_icon_button.dart';
import 'package:aramex/common/widget/button/custom_outline_button.dart';
import 'package:aramex/common/widget/button/rounded_button.dart';
import 'package:aramex/common/widget/card/custom_list_tile.dart';
import 'package:aramex/common/widget/card_wrapper.dart';
import 'package:aramex/common/widget/checkbox/custom_checkbox.dart';
import 'package:aramex/common/widget/common_error_widget.dart';
import 'package:aramex/common/widget/common_loading_widget.dart';
import 'package:aramex/common/widget/common_no_data_widget.dart';
import 'package:aramex/common/widget/custom_app_bar.dart';
import 'package:aramex/common/widget/dialog/request_confirm_dialog.dart';
import 'package:aramex/common/widget/options_bottomsheet.dart';
import 'package:aramex/common/widget/text_field/custom_textfield.dart';
import 'package:aramex/feature/account_payment/cubit/user_wallet_list_cubit.dart';
import 'package:aramex/feature/account_payment/model/user_wallet.dart';
import 'package:aramex/feature/account_payment/model/wallet.dart';
import 'package:aramex/feature/request_pay/cubit/payment_request_cubit.dart';
import 'package:aramex/feature/request_pay/cubit/wallet_list_cubit.dart';
import 'package:aramex/feature/request_pay/enum/payment_request_enum.dart';
import 'package:aramex/feature/request_pay/model/wallet_transfer_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

class WalletTransferRequestPayWidget extends StatefulWidget {
  final double requestedAmount;
  const WalletTransferRequestPayWidget(
      {Key? key, required this.requestedAmount})
      : super(key: key);

  @override
  State<WalletTransferRequestPayWidget> createState() =>
      _WalletTransferRequestPayWidgetState();
}

class _WalletTransferRequestPayWidgetState
    extends State<WalletTransferRequestPayWidget> {
  final ValueNotifier<List<Wallet>> _wallets = ValueNotifier([]);
  final TextEditingController _walletController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  int? _selectedWalletId;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool showAddWalletOptions = false;
  bool _saveForFutureTransaction = false;
  bool _isLoading = false;

  UserWallet? _selectedUserWallet;

  @override
  void initState() {
    context.read<UserWalletListCubit>().fetchUserWallet();
    context.read<WalletListCubit>().fetchWallets();
    super.initState();
  }

  _clearAllTextField() {
    _walletController.text = "";
    _usernameController.text = "";
    _selectedWalletId = null;
  }

  _updateLoadingStatus(status) {
    setState(() {
      _isLoading = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.requestPay.tr(),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<WalletListCubit, CommonState>(
              listener: (context, state) {
                if (state is CommonDataFetchedState<Wallet>) {
                  _wallets.value = state.data;
                }
              },
            ),
            BlocListener<PaymentRequestCubit, CommonState>(
              listener: (context, state) {
                if (state is CommonLoadingState) {
                  _updateLoadingStatus(true);
                } else {
                  _updateLoadingStatus(false);
                }

                if (state is CommonDataSuccessState) {
                  showRequestConfirmDialog(context: context);
                } else if (state is CommonErrorState) {
                  SnackBarUtils.showErrorBar(
                    context: context,
                    message: state.message,
                  );
                }
              },
            )
          ],
          child: Form(
            key: _formkey,
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: CustomTheme.symmetricHozPadding,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.hp),
                            Text(
                              LocaleKeys.paymentOptions.tr(),
                              style: _textTheme.headline3!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            CardWrapper(
                              bottomMargin: 24.hp,
                              topMargin: 16.hp,
                              verticalPadding: 4,
                              child:
                                  BlocBuilder<UserWalletListCubit, CommonState>(
                                builder: (context, state) {
                                  if (state is CommonLoadingState) {
                                    return const CommonLoadingWidget();
                                  } else if (state is CommonErrorState) {
                                    return CommonErrorWidget(
                                        message: state.message);
                                  } else if (state
                                      is CommonDataFetchedState<UserWallet>) {
                                    return Column(
                                      children: List.generate(
                                        state.data.length,
                                        (index) {
                                          return CustomListTile(
                                            title:
                                                state.data[index].wallet.name,
                                            description:
                                                state.data[index].username,
                                            descriptionFontWeight:
                                                FontWeight.w400,
                                            descriptionFontSize: 14,
                                            titleFontSize: 16,
                                            showBorder:
                                                !(state.data.length - 1 ==
                                                    index),
                                            suffixIcon:
                                                _selectedUserWallet?.id ==
                                                        state.data[index].id
                                                    ? Icons.check_rounded
                                                    : null,
                                            suffixColor: _theme.primaryColor,
                                            titleFontWeight: FontWeight.bold,
                                            // image: state.data[index].wallet
                                            //         .media?.path ??
                                            //     "",
                                            onPressed: () {
                                              setState(() {
                                                if (_selectedUserWallet?.id ==
                                                    state.data[index].id) {
                                                  _selectedUserWallet = null;
                                                } else {
                                                  _selectedUserWallet =
                                                      state.data[index];
                                                }
                                              });
                                              showAddWalletOptions = false;
                                              _clearAllTextField();
                                            },
                                          );
                                        },
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: CommonNoDataWidget(
                                          message:
                                              LocaleKeys.noSavedBankFound.tr()),
                                    );
                                  }
                                },
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  showAddWalletOptions = true;
                                  _selectedUserWallet = null;
                                });
                              },
                              child: Row(
                                children: [
                                  CustomIconButton(
                                    icon: Icons.add_rounded,
                                    iconColor: _theme.primaryColor,
                                  ),
                                  SizedBox(width: 20.wp),
                                  Text(
                                    LocaleKeys.newWallet.tr(),
                                    style: _textTheme.headline6!.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.hp),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: showAddWalletOptions
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                              label:
                                                  LocaleKeys.selectWallet.tr(),
                                              hintText: "Esewa",
                                              readOnly: true,
                                              suffixIcon: Icons
                                                  .keyboard_arrow_down_rounded,
                                              controller: _walletController,
                                              validator: (val) {
                                                return FormValidator
                                                    .validateFieldNotEmpty(
                                                  val,
                                                  LocaleKeys.wallets.tr(),
                                                );
                                              },
                                              onPressed: () {
                                                showOptionsBottomSheet(
                                                  label:
                                                      LocaleKeys.wallets.tr(),
                                                  options: wallets
                                                      .map((e) => e.name)
                                                      .toList(),
                                                  onChanged: (val) {
                                                    _walletController.text =
                                                        val;
                                                    _selectedWalletId = wallets
                                                        .firstWhere((e) =>
                                                            e.name == val)
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
                                            return FormValidator
                                                .validateFieldNotEmpty(
                                              val,
                                              LocaleKeys.walletID.tr(),
                                            );
                                          },
                                        ),
                                        CustomCheckbox(
                                          status: _saveForFutureTransaction,
                                          onChanged: (val) {
                                            setState(() {
                                              _saveForFutureTransaction = val;
                                            });
                                          },
                                          title: LocaleKeys
                                              .saveAccountForFuturetransaction
                                              .tr(),
                                        ),
                                        SizedBox(height: 20.hp),
                                      ],
                                    )
                                  : Container(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Container(
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
                              title: LocaleKeys.confirmRequest.tr(),
                              onPressed: () {
                                if (_selectedUserWallet != null) {
                                  context
                                      .read<PaymentRequestCubit>()
                                      .requestPayment(
                                        amount: widget.requestedAmount,
                                        option:
                                            PaymentRequestOption.WalletTransfer,
                                        bankTransferData: null,
                                        walletTransferData:
                                            WalletTransferData.fromUserWallet(
                                                _selectedUserWallet!),
                                      );
                                } else if (showAddWalletOptions) {
                                  if (_formkey.currentState!.validate()) {
                                    context
                                        .read<PaymentRequestCubit>()
                                        .requestPayment(
                                          amount: widget.requestedAmount,
                                          option: PaymentRequestOption
                                              .WalletTransfer,
                                          walletTransferData:
                                              WalletTransferData(
                                            username: _usernameController.text,
                                            walletId: _selectedWalletId!,
                                          ),
                                          bankTransferData: null,
                                        );
                                  }
                                } else {
                                  SnackBarUtils.showSuccessBar(
                                    context: context,
                                    message: "Please Select Wallet",
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
