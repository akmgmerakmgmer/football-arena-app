import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/buttons/google_button_no_birthdate.dart';
import 'package:in_zone_app/widgets/containers/image_background_container.dart';
import 'package:in_zone_app/widgets/containers/page_container_with_footer.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/screens/signup/signup_form_no_birthdate.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return PageContainerWithFooter(
        showHeader: false,
        body: SingleChildScrollView(
          child: ImageBackgroundContainer(
              width: 350,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 12),
                  // Title
                  TextWidget(
                    title: AppLocalizations.of(context)!.createAccount,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  const SignupFormNoBirthdate(),
                  const SizedBox(
                    height: 12,
                  ),
                  const GoogleButtonNoBirthdate(),
                  const SizedBox(height: 12),
                ],
              )),
        ));
  }
}
