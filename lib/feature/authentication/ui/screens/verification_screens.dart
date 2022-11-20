import 'package:aramex/feature/authentication/ui/widgets/verification_widgets.dart';
import 'package:flutter/material.dart';

class VerificationScreens extends StatelessWidget {
  final String email;
  const VerificationScreens({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VerificationWidgets(email: email);
  }
}
