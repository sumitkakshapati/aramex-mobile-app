import 'package:aramex/app/theme.dart';
import 'package:aramex/common/constant/locale_keys.dart';
import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/navigation/navigation_service.dart';
import 'package:aramex/common/route/routes.dart';
import 'package:aramex/common/widget/common_error_widget.dart';
import 'package:aramex/common/widget/common_loading_widget.dart';
import 'package:aramex/common/widget/custom_app_bar.dart';
import 'package:aramex/feature/payment_history/model/payment_request.dart';
import 'package:aramex/feature/payment_history/ui/widgets/payment_card.dart';
import 'package:aramex/feature/request_pay/cubit/list_payment_request_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentHistoryWidgets extends StatefulWidget {
  const PaymentHistoryWidgets({Key? key}) : super(key: key);

  @override
  State<PaymentHistoryWidgets> createState() => _PaymentHistoryWidgetsState();
}

class _PaymentHistoryWidgetsState extends State<PaymentHistoryWidgets> {
  @override
  void initState() {
    context.read<ListPaymentRequestCubit>().fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.paymentHistory.tr(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigationService.pushNamed(routeName: Routes.requestPay);
        },
        backgroundColor: CustomTheme.primaryColor,
        child: const Icon(
          Icons.add_rounded,
          size: 20,
        ),
      ),
      body: Container(
        child: BlocBuilder<ListPaymentRequestCubit, CommonState>(
          builder: (context, state) {
            if (state is CommonLoadingState) {
              return const CommonLoadingWidget();
            } else if (state is CommonErrorState) {
              return CommonErrorWidget(message: state.message);
            } else if (state is CommonDataFetchedState<PaymentRequest>) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return PaymentCard(
                    horizontalMargin: CustomTheme.symmetricHozPadding,
                    paymentRequest: state.data[index],
                  );
                },
                itemCount: state.data.length,
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
