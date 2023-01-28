import 'package:aramex/app/theme.dart';
import 'package:aramex/common/cubit/common_state.dart';
import 'package:aramex/common/widget/common_error_widget.dart';
import 'package:aramex/common/widget/common_loading_widget.dart';
import 'package:aramex/feature/dashboard/cubit/homepage_cubit.dart';
import 'package:aramex/feature/dashboard/model/homepage_data.dart';
import 'package:aramex/feature/home/ui/widgets/homepage_header.dart';
import 'package:aramex/feature/home/ui/widgets/homepage_shipment_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageWidgets extends StatefulWidget {
  final VoidCallback onProfilepressed;
  const HomePageWidgets({Key? key, required this.onProfilepressed})
      : super(key: key);

  @override
  State<HomePageWidgets> createState() => _HomePageWidgetsState();
}

class _HomePageWidgetsState extends State<HomePageWidgets> {
  @override
  void initState() {
    context.read<HomepageCubit>().homepage();
    super.initState();
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
              HomePageHeader(onProfilepressed: widget.onProfilepressed),
              const SizedBox(height: 28),
              BlocBuilder<HomepageCubit, CommonState>(
                buildWhen: (previous, current) {
                  if (current is CommonDummyLoadingState) {
                    return false;
                  } else {
                    return true;
                  }
                },
                builder: (context, state) {
                  if (state is CommonLoadingState) {
                    return Container(
                      height: MediaQuery.of(context).size.height - 220,
                      alignment: Alignment.center,
                      child: const CommonLoadingWidget(),
                    );
                  } else if (state is CommonDataSuccessState<HomepageData>) {
                    return HomepageShipmentWidget(homepageData: state.data!);
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
