import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/buttons/google_button.dart';
import 'package:in_zone_app/widgets/containers/image_background_container.dart';
import 'package:in_zone_app/widgets/containers/page_container_with_footer.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/screens/signup/signup_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return PageContainerWithFooter(
        showHeader: false,
        body: ImageBackgroundContainer(
            width: 350,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  title: AppLocalizations.of(context)!.createAccount,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                const SignupForm(),
                const SizedBox(
                  height: 16,
                ),
                // const GoogleButton()
              ],
            )));
  }
}
