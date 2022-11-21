import 'package:aramex/app/theme.dart';
import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/enum/date_duration.dart';
import 'package:aramex/common/util/date_utils.dart';
import 'package:aramex/common/widget/common_error_widget.dart';
import 'package:aramex/common/widget/common_loading_widget.dart';
import 'package:aramex/feature/dashboard/cubit/homepage_cubit.dart';
import 'package:aramex/feature/dashboard/model/homepage_data.dart';
import 'package:aramex/feature/home/ui/widgets/homepage_header.dart';
import 'package:aramex/feature/home/ui/widgets/homepage_shipment_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageWidgets extends StatefulWidget {
  const HomePageWidgets({Key? key}) : super(key: key);

  @override
  State<HomePageWidgets> createState() => _HomePageWidgetsState();
}

class _HomePageWidgetsState extends State<HomePageWidgets> {
  // final ValueNotifier<DateTime?> _startDate = ValueNotifier(null);
  // final ValueNotifier<DateTime?> _endDate = ValueNotifier(null);
  final ValueNotifier<DateDuration?> _currentDateDuration =
      ValueNotifier(DateDuration.Week);

  @override
  void initState() {
    updateOnTimePeriod();
    _currentDateDuration.addListener(updateOnTimePeriod);
    super.initState();
  }

  updateOnTimePeriod() {
    if (_currentDateDuration.value != null) {
      final _currentDateRange =
          DateTimeUtils.getDateRange(_currentDateDuration.value!);
      context.read<HomepageCubit>().homepage(
            startDate: _currentDateRange.start,
            endDate: _currentDateRange.end,
          );
    }
  }

  @override
  void dispose() {
    _currentDateDuration.removeListener(updateOnTimePeriod);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: CustomTheme.symmetricHozPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomePageHeader(),
              const SizedBox(height: 28),
              BlocBuilder<HomepageCubit, CommonState>(
                builder: (context, state) {
                  if (state is CommonLoadingState) {
                    return const CommonLoadingWidget();
                  } else if (state is CommonDataSuccessState<HomepageData>) {
                    return HomepageShipmentWidget(
                      homepageData: state.data!,
                      currentDateDuration: _currentDateDuration,
                    );
                  } else if (state is CommonErrorState) {
                    return CommonErrorWidget(message: state.message);
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
