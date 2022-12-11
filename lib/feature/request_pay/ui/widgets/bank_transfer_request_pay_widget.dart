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
import 'package:aramex/feature/request_pay/cubit/bank_account_list_cubit.dart';
import 'package:aramex/feature/request_pay/cubit/bank_branch_list_cubit.dart';
import 'package:aramex/feature/request_pay/cubit/bank_list_cubit.dart';
import 'package:aramex/feature/request_pay/cubit/payment_request_cubit.dart';
import 'package:aramex/feature/request_pay/enum/payment_request_enum.dart';
import 'package:aramex/feature/request_pay/model/bank.dart';
import 'package:aramex/feature/request_pay/model/bank_account.dart';
import 'package:aramex/feature/request_pay/model/bank_branch.dart';
import 'package:aramex/feature/request_pay/model/bank_transter_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

class BankTransferRequestPayWidget extends StatefulWidget {
  final double requestedAmount;
  const BankTransferRequestPayWidget({Key? key, required this.requestedAmount})
      : super(key: key);

  @override
  State<BankTransferRequestPayWidget> createState() =>
      _BankTransferRequestPayWidgetState();
}

class _BankTransferRequestPayWidgetState
    extends State<BankTransferRequestPayWidget> {
  final ValueNotifier<List<Bank>> _banks = ValueNotifier([]);
  final ValueNotifier<List<BankBranch>> _bankBranches = ValueNotifier([]);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _bankController = TextEditingController();
  final TextEditingController _bankBranchController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _accountHolderNameController =
      TextEditingController();
  int? _selectedBank;
  int? _selectedBranch;

  bool _isLoading = false;
  bool showAddBankOptions = false;
  bool _saveForFutureTransaction = false;
  BankAccount? _selectedBankAccount;

  @override
  void initState() {
    context.read<BankAccountListCubit>().fetchAccountList();
    context.read<BankListCubit>().fetchBankList();
    super.initState();
  }

  _clearAllTextField() {
    _bankController.text = "";
    _bankBranchController.text = "";
    _accountNumberController.text = "";
    _accountHolderNameController.text = "";
    _selectedBank = null;
    _selectedBranch = null;
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
            BlocListener<BankListCubit, CommonState>(
              listener: (context, state) {
                if (state is CommonDataFetchedState<Bank>) {
                  _banks.value = state.data;
                }
              },
            ),
            BlocListener<BankBranchListCubit, CommonState>(
              listener: (context, state) {
                if (state is CommonDataFetchedState<BankBranch>) {
                  _bankBranches.value = state.data;
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
                                BlocBuilder<BankAccountListCubit, CommonState>(
                              builder: (context, state) {
                                if (state is CommonLoadingState) {
                                  return const CommonLoadingWidget();
                                } else if (state is CommonErrorState) {
                                  return CommonErrorWidget(
                                      message: state.message);
                                } else if (state
                                    is CommonDataFetchedState<BankAccount>) {
                                  return Column(
                                    children: List.generate(
                                      state.data.length,
                                      (index) {
                                        return CustomListTile(
                                          title: state.data[index].bank?.name ??
                                              "",
                                          description:
                                              state.data[index].accountNumber,
                                          descriptionFontWeight:
                                              FontWeight.w400,
                                          descriptionFontSize: 14,
                                          titleFontSize: 16,
                                          showBorder:
                                              !(state.data.length - 1 == index),
                                          suffixIcon:
                                              _selectedBankAccount?.id ==
                                                      state.data[index].id
                                                  ? Icons.check_rounded
                                                  : null,
                                          suffixColor: _theme.primaryColor,
                                          titleFontWeight: FontWeight.bold,
                                          image: state.data[index].bank?.image
                                                  ?.path ??
                                              "",
                                          onPressed: () {
                                            setState(() {
                                              if (_selectedBankAccount?.id ==
                                                  state.data[index].id) {
                                                _selectedBankAccount = null;
                                              } else {
                                                _selectedBankAccount =
                                                    state.data[index];
                                              }
                                            });
                                            showAddBankOptions = false;
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
                                showAddBankOptions = true;
                                _selectedBankAccount = null;
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
                                  LocaleKeys.newBank.tr(),
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
                            child: showAddBankOptions
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        LocaleKeys.addBankDetails.tr(),
                                        style: _textTheme.headline3!.copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(height: 16.hp),
                                      ValueListenableBuilder<List<Bank>>(
                                        valueListenable: _banks,
                                        builder: (context, banks, _) {
                                          return CustomTextField(
                                            label: LocaleKeys.selectBank.tr(),
                                            hintText: "Select Bank",
                                            readOnly: true,
                                            suffixIcon: Icons
                                                .keyboard_arrow_down_rounded,
                                            controller: _bankController,
                                            validator: (val) {
                                              return FormValidator
                                                  .validateFieldNotEmpty(val,
                                                      LocaleKeys.bank.tr());
                                            },
                                            onPressed: () {
                                              showOptionsBottomSheet(
                                                label: LocaleKeys.bank.tr(),
                                                options: banks
                                                    .map((e) => e.name)
                                                    .toList(),
                                                onChanged: (val) {
                                                  _bankController.text = val;
                                                  _selectedBank = banks
                                                      .firstWhere(
                                                          (e) => e.name == val)
                                                      .id;
                                                  context
                                                      .read<
                                                          BankBranchListCubit>()
                                                      .fetchBankBranchList(
                                                          _selectedBank!);
                                                  _bankBranchController.text =
                                                      "";
                                                  _selectedBranch = null;
                                                },
                                                context: context,
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      ValueListenableBuilder<List<BankBranch>>(
                                        valueListenable: _bankBranches,
                                        builder: (context, bankBranches, _) {
                                          return CustomTextField(
                                            label: LocaleKeys.selectBankBranch
                                                .tr(),
                                            hintText: "Select Branch",
                                            readOnly: true,
                                            suffixIcon: Icons
                                                .keyboard_arrow_down_rounded,
                                            controller: _bankBranchController,
                                            validator: (val) {
                                              return FormValidator
                                                  .validateFieldNotEmpty(
                                                      val,
                                                      LocaleKeys.bankBranch
                                                          .tr());
                                            },
                                            onPressed: () {
                                              if (_bankBranches
                                                  .value.isNotEmpty) {
                                                showOptionsBottomSheet(
                                                  label: LocaleKeys.bankBranch
                                                      .tr(),
                                                  options: bankBranches
                                                      .map((e) => e.location)
                                                      .toList(),
                                                  onChanged: (val) {
                                                    _bankBranchController.text =
                                                        val;
                                                    _selectedBranch =
                                                        bankBranches
                                                            .firstWhere((e) =>
                                                                e.location ==
                                                                val)
                                                            .id;
                                                  },
                                                  context: context,
                                                );
                                              }
                                            },
                                          );
                                        },
                                      ),
                                      CustomTextField(
                                        label:
                                            LocaleKeys.accountHolderName.tr(),
                                        hintText: "eg. Sumit Kakshapati",
                                        controller:
                                            _accountHolderNameController,
                                        validator: (val) {
                                          return FormValidator
                                              .validateFieldNotEmpty(
                                                  val,
                                                  LocaleKeys.accountHolderName
                                                      .tr());
                                        },
                                      ),
                                      CustomTextField(
                                        label: LocaleKeys.accountNumber.tr(),
                                        hintText: "eg. 1234 5678 9123",
                                        bottomPadding: 16.hp,
                                        controller: _accountNumberController,
                                        validator: (val) {
                                          return FormValidator
                                              .validateFieldNotEmpty(
                                                  val,
                                                  LocaleKeys.accountNumber
                                                      .tr());
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
                              if (_selectedBankAccount != null) {
                                context
                                    .read<PaymentRequestCubit>()
                                    .requestPayment(
                                      amount: widget.requestedAmount,
                                      option: PaymentRequestOption.BankTransfer,
                                      bankTransferData:
                                          BankTransferData.fromBankAccount(
                                              _selectedBankAccount!),
                                      walletTransferData: null,
                                    );
                              } else if (showAddBankOptions) {
                                if (_formKey.currentState!.validate()) {
                                  context
                                      .read<PaymentRequestCubit>()
                                      .requestPayment(
                                        amount: widget.requestedAmount,
                                        option:
                                            PaymentRequestOption.BankTransfer,
                                        bankTransferData: BankTransferData(
                                          bankId: _selectedBank,
                                          branchId: _selectedBranch,
                                          accountHolderName:
                                              _accountHolderNameController.text,
                                          accountNumber:
                                              _accountNumberController.text,
                                        ),
                                        walletTransferData: null,
                                      );
                                }
                              } else {
                                SnackBarUtils.showSuccessBar(
                                  context: context,
                                  message: "Please Select Bank",
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
    );
  }
}
