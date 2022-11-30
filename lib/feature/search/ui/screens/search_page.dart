import 'package:aramex/feature/search/cubit/recent_search_cubit.dart';
import 'package:aramex/feature/search/ui/widgets/search_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecentSearchCubit(),
      child: const SearchWidgets(),
    );
  }
}
