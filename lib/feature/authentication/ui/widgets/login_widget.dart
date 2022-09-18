import 'package:boilerplate/app/theme.dart';
import 'package:boilerplate/common/util/size_utils.dart';
import 'package:boilerplate/common/widget/button/rounded_button.dart';
import 'package:boilerplate/common/widget/text_field/custom_textfield.dart';
import 'package:flutter/material.dart';

class LoginWidgets extends StatelessWidget {
  const LoginWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: CustomTheme.symmetricHozPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).viewPadding.top + 40.hp),
            Text(
              "aramex",
              style: _textTheme.headline1!.copyWith(
                fontSize: 56,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.2,
                color: CustomTheme.primaryColor,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 48.hp, bottom: 8.hp),
              child: Text(
                "Login to Aramex",
                style: _textTheme.headline1!.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            ),
            Text(
              "We cover all kind of transportation.",
              style: _textTheme.headline6!.copyWith(
                fontWeight: FontWeight.w400,
                letterSpacing: 0.2,
              ),
            ),
            SizedBox(height: 48.hp),
            const CustomTextField(
              label: "Email Address",
              hintText: "******@gmail.com",
            ),
            const CustomTextField(
              label: "Password",
              hintText: "********",
              obscureText: true,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Forgot Password?",
                style: _textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 24.hp),
            CustomRoundedButtom(
              title: "Login",
              onPressed: () {},
            ),
            SizedBox(height: 24.hp),
            Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  text: "Don't have an account? ",
                  style: _textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(
                      text: "Register Now",
                      style: _textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: CustomTheme.primaryColor,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
