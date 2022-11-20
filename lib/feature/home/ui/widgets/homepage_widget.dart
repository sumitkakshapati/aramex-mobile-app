import 'package:aramex/app/theme.dart';
import 'package:aramex/common/cubit/common_state.dart';
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
  @override
  void initState() {
    context.read<HomepageCubit>().homepage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = MediaQuery.of(context).size.width;

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
                    return const CupertinoActivityIndicator();
                  } else if (state is CommonDataSuccessState<HomepageData>) {
                    return HomepageShipmentWidget(homepageData: state.data!);
                  } else if (state is CommonErrorState) {
                    return Text(state.message);
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
