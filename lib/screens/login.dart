import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/buttons/google_button.dart';
import 'package:in_zone_app/widgets/containers/image_background_container.dart';
import 'package:in_zone_app/widgets/containers/page_container_with_footer.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/screens/login/login_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Login extends StatelessWidget {
  const Login({super.key});

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
                  title: AppLocalizations.of(context)!.login,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                const LoginForm(),
                const SizedBox(
                  height: 16,
                ),
                // GoogleButton()
              ],
            )));
  }
}
