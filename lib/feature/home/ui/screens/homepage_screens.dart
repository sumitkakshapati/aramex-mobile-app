import 'package:aramex/feature/home/ui/widgets/homepage_widget.dart';
import 'package:flutter/material.dart';

class HomepageScreens extends StatelessWidget {
  final VoidCallback onProfilepressed;
  const HomepageScreens({Key? key, required this.onProfilepressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomePageWidgets(onProfilepressed: onProfilepressed);
  }
}
