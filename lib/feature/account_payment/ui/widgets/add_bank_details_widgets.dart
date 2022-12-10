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
import 'package:aramex/feature/request_pay/cubit/bank_branch_list_cubit.dart';
import 'package:aramex/feature/request_pay/cubit/bank_list_cubit.dart';
import 'package:aramex/feature/request_pay/cubit/save_bank_cubit.dart';
import 'package:aramex/feature/request_pay/cubit/update_bank_account_cubit.dart';
import 'package:aramex/feature/request_pay/model/bank.dart';
import 'package:aramex/feature/request_pay/model/bank_account.dart';
import 'package:aramex/feature/request_pay/model/bank_branch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

class AddBankDetailsWidgets extends StatefulWidget {
  final BankAccount? bankAccount;
  const AddBankDetailsWidgets({Key? key, this.bankAccount}) : super(key: key);

  @override
  State<AddBankDetailsWidgets> createState() => _AddBankDetailsWidgetsState();
}

class _AddBankDetailsWidgetsState extends State<AddBankDetailsWidgets> {
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

  @override
  void initState() {
    super.initState();
    context.read<BankListCubit>().fetchBankList();
    if (widget.bankAccount != null) {
      _bankController.text = widget.bankAccount?.bank?.name ?? "";
      _selectedBank = widget.bankAccount?.bank?.id;
      _bankBranchController.text =
          widget.bankAccount?.bankBranch?.location ?? "";
      _selectedBranch = widget.bankAccount?.bankBranch?.id;
      _accountHolderNameController.text = widget.bankAccount?.accountName ?? "";
      _accountNumberController.text = widget.bankAccount?.accountNumber ?? "";
    }
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
            BlocListener<SaveBankCubit, CommonState>(
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

                if (state is CommonDataSuccessState<BankAccount>) {
                  SnackBarUtils.showSuccessBar(
                    context: context,
                    message: "Bank saved successfully",
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
            BlocListener<UpdateBankAccountCubit, CommonState>(
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

                if (state is CommonDataSuccessState<BankAccount>) {
                  SnackBarUtils.showSuccessBar(
                    context: context,
                    message: "Bank updated successfully",
                  );
                  NavigationService.pop();
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
            child: Form(
              key: _formKey,
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
                                suffixIcon: Icons.keyboard_arrow_down_rounded,
                                controller: _bankController,
                                validator: (val) {
                                  return FormValidator.validateFieldNotEmpty(
                                      val, LocaleKeys.bank.tr());
                                },
                                onPressed: () {
                                  showOptionsBottomSheet(
                                    label: LocaleKeys.bank.tr(),
                                    options: banks.map((e) => e.name).toList(),
                                    onChanged: (val) {
                                      _bankController.text = val;
                                      _selectedBank = banks
                                          .firstWhere((e) => e.name == val)
                                          .id;
                                      context
                                          .read<BankBranchListCubit>()
                                          .fetchBankBranchList(_selectedBank!);
                                      _bankBranchController.text = "";
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
                                label: LocaleKeys.selectBankBranch.tr(),
                                hintText: "Select Branch",
                                readOnly: true,
                                suffixIcon: Icons.keyboard_arrow_down_rounded,
                                controller: _bankBranchController,
                                validator: (val) {
                                  return FormValidator.validateFieldNotEmpty(
                                      val, LocaleKeys.bankBranch.tr());
                                },
                                onPressed: () {
                                  if (_bankBranches.value.isNotEmpty) {
                                    showOptionsBottomSheet(
                                      label: LocaleKeys.bankBranch.tr(),
                                      options: bankBranches
                                          .map((e) => e.location)
                                          .toList(),
                                      onChanged: (val) {
                                        _bankBranchController.text = val;
                                        _selectedBranch = bankBranches
                                            .firstWhere(
                                                (e) => e.location == val)
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
                            label: LocaleKeys.accountHolderName.tr(),
                            hintText: "eg. Sumit Kakshapati",
                            controller: _accountHolderNameController,
                            validator: (val) {
                              return FormValidator.validateFieldNotEmpty(
                                  val, LocaleKeys.accountHolderName.tr());
                            },
                          ),
                          CustomTextField(
                            label: LocaleKeys.accountNumber.tr(),
                            hintText: "eg. 1234 5678 9123",
                            bottomPadding: 16.hp,
                            controller: _accountNumberController,
                            validator: (val) {
                              return FormValidator.validateFieldNotEmpty(
                                  val, LocaleKeys.accountNumber.tr());
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
                                    title:
                                        "${widget.bankAccount != null ? "Update" : "Save"} Account",
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        if (widget.bankAccount != null) {
                                          context
                                              .read<UpdateBankAccountCubit>()
                                              .updateBankAccount(
                                                bankAccountId:
                                                    widget.bankAccount!.id,
                                                bankId: _selectedBank!,
                                                branchId: _selectedBranch!,
                                                accountName:
                                                    _accountHolderNameController
                                                        .text,
                                                accountNumber:
                                                    _accountNumberController
                                                        .text,
                                              );
                                        } else {
                                          context
                                              .read<SaveBankCubit>()
                                              .saveBank(
                                                bankId: _selectedBank!,
                                                branchId: _selectedBranch!,
                                                accountName:
                                                    _accountHolderNameController
                                                        .text,
                                                accountNumber:
                                                    _accountNumberController
                                                        .text,
                                              );
                                        }
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
