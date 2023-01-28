import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/navigation/navigation_service.dart';
import 'package:aramex/common/util/form_validator.dart';
import 'package:aramex/common/util/size_utils.dart';
import 'package:aramex/common/util/snackbar_utils.dart';
import 'package:aramex/common/widget/card/custom_list_tile.dart';
import 'package:aramex/common/widget/card_wrapper.dart';
import 'package:aramex/common/widget/common_error_widget.dart';
import 'package:aramex/common/widget/common_loading_widget.dart';
import 'package:aramex/common/widget/custom_app_bar.dart';
import 'package:aramex/common/widget/dialog/request_confirm_dialog.dart';
import 'package:aramex/common/widget/text_field/custom_textfield.dart';
import 'package:aramex/feature/request_pay/cubit/fetch_payment_info_cubit.dart';
import 'package:aramex/feature/request_pay/cubit/payment_request_cubit.dart';
import 'package:aramex/feature/request_pay/enum/payment_request_enum.dart';
import 'package:aramex/feature/request_pay/model/payment_request_info.dart';
import 'package:aramex/feature/request_pay/ui/screens/bank_transfer_request_pay_screens.dart';
import 'package:aramex/feature/request_pay/ui/screens/wallet_transfer_request_pay_screens.dart';
import 'package:aramex/feature/splash/resource/startup_repository.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_overlay/loading_overlay.dart';

class RequestPayWidgets extends StatefulWidget {
  const RequestPayWidgets({Key? key}) : super(key: key);

  @override
  State<RequestPayWidgets> createState() => _RequestPayWidgetsState();
}

class _RequestPayWidgetsState extends State<RequestPayWidgets> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _requestedAmountController =
      TextEditingController();
  bool _isLoading = false;

  _updateLoadingStatus(bool status) {
    setState(() {
      _isLoading = status;
    });
  }

  @override
  void initState() {
    context.read<FetchPaymentInfoCubit>().fetchPaymentInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _configRepository = RepositoryProvider.of<StartUpRepository>(context);

    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.requestPay.tr(),
        ),
        body: BlocListener<PaymentRequestCubit, CommonState>(
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
          child: BlocConsumer<FetchPaymentInfoCubit, CommonState>(
            listener: (context, state) {
              if (state is CommonDataSuccessState<PaymentRequestInfo>) {
                if (state.data != null) {
                  _requestedAmountController.text =
                      state.data!.unrequestCOD.toString();
                }
              }
            },
            builder: (context, state) {
              if (state is CommonLoadingState) {
                return const CommonLoadingWidget();
              } else if (state is CommonErrorState) {
                return CommonErrorWidget(message: state.message);
              } else if (state is CommonDataSuccessState<PaymentRequestInfo>) {
                return Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: CustomTheme.symmetricHozPadding,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 40.hp),
                          DottedBorder(
                            color: CustomTheme.skyBlue,
                            borderType: BorderType.RRect,
                            dashPattern: const [6],
                            radius: const Radius.circular(12),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.wp,
                                vertical: 24.wp,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0x265BCADD),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    LocaleKeys.availableAmountToWithdraw.tr(),
                                    style: _textTheme.headline6,
                                  ),
                                  SizedBox(height: 12.hp),
                                  Text(
                                    "${state.data?.availableCOD}",
                                    style: _textTheme.headline3!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    child: const Divider(height: 0),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: "${LocaleKeys.note.tr()}: ",
                                      style: _textTheme.headline6!.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: LocaleKeys.remainingRequestPay
                                              .tr(),
                                          style: _textTheme.headline6,
                                        ),
                                        TextSpan(
                                          text:
                                              " ${state.data?.currentWeekRequestCount}/${_configRepository.config.value.maxPaymentRequest}",
                                          style: _textTheme.headline6!.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 32.hp),
                          CustomTextField(
                            label: LocaleKeys.requestableAmountRs.tr(),
                            hintText: "eg. 10000",
                            bottomPadding: 32.hp,
                            readOnly: true,
                            validator: (val) {
                              return FormValidator.validateAmountField(
                                val,
                                LocaleKeys.requestableAmountRs.tr(),
                              );
                            },
                            controller: _requestedAmountController,
                          ),
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
                            child: Column(
                              children: [
                                CustomListTile(
                                  title: LocaleKeys.cash.tr(),
                                  icon: Iconsax.money,
                                  iconColor: CustomTheme.purple,
                                  showNextIcon: true,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      if (double.parse(
                                              _requestedAmountController
                                                  .text) <=
                                          _configRepository.config.value
                                              .maxCashWithdrawLimit) {
                                        context
                                            .read<PaymentRequestCubit>()
                                            .requestPayment(
                                              amount: double.parse(
                                                  _requestedAmountController
                                                      .text),
                                              option: PaymentRequestOption.Cash,
                                              bankTransferData: null,
                                              walletTransferData: null,
                                            );
                                      } else {
                                        SnackBarUtils.showErrorBar(
                                          context: context,
                                          message:
                                              "You can request up to Rs. ${_configRepository.config.value.maxCashWithdrawLimit} from cash option",
                                        );
                                      }
                                    }
                                  },
                                ),
                                CustomListTile(
                                  title: LocaleKeys.bankTransfer.tr(),
                                  icon: Iconsax.bank,
                                  iconColor: CustomTheme.skyBlue,
                                  showNextIcon: true,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      NavigationService.push(
                                        target: BankTransferRequestPayScreen(
                                          requestedAmount: double.parse(
                                            _requestedAmountController.text,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                                CustomListTile(
                                  title: LocaleKeys.walletTransfer.tr(),
                                  icon: Iconsax.wallet,
                                  iconColor: CustomTheme.green,
                                  showBorder: false,
                                  showNextIcon: true,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      if (double.parse(
                                              _requestedAmountController
                                                  .text) <=
                                          _configRepository.config.value
                                              .maxWalletWithdrawLimit) {
                                        NavigationService.push(
                                          target:
                                              WalletTransferRequestPayScreen(
                                            requestedAmount: double.parse(
                                              _requestedAmountController.text,
                                            ),
                                          ),
                                        );
                                      } else {
                                        SnackBarUtils.showErrorBar(
                                          context: context,
                                          message:
                                              "You can request up to Rs. ${_configRepository.config.value.maxWalletWithdrawLimit} from wallet option.",
                                        );
                                      }
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: "${LocaleKeys.note.tr()}: ",
                              style: _textTheme.headline6!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: LocaleKeys
                                      .youCanRequestPaymentUpToNinCashinHandOptionsAndNinWalletOptions
                                      .tr(args: [
                                    "${_configRepository.config.value.maxCashWithdrawLimit}",
                                    "${_configRepository.config.value.maxWalletWithdrawLimit}"
                                  ]),
                                  style: _textTheme.headline6!,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
