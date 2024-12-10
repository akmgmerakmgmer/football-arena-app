import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/utilities/auth.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class GoogleButton extends StatelessWidget {
  GoogleButton({super.key});

  String displayName = '';

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _handleSignIn(context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return; // User canceled the sign-in
      PostApi('email-login', {'email': googleUser.email}, (res) async {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('token', res['accessToken']);
        String? token = localStorage.getString(('token'));
        // ignore: use_build_context_synchronously
        await Auth().getUser(token, context);
        Navigator.pushReplacementNamed(context, '/');
      }).post(context);
    } catch (error) {
      print('Error signing in: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleSignIn(context),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color:
                    Colors.black.withOpacity(0.2), // Shadow color with opacity
                blurRadius: 6, // Spread radius (similar to shadow-md)
                offset:
                    const Offset(0, 3), // Changes the position of the shadow
              ),
            ],
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.white,
                Colors.white, // Start color
                Colors.white.withOpacity(0.75), // End color
              ],
              begin: Alignment.topCenter, // Gradient starts here
              end: Alignment.bottomCenter, // Gradient ends here
            ),
            borderRadius: const BorderRadius.all(Radius.circular(4))),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/icons8-google.svg',
                semanticsLabel: 'Google Icon', // Optional, for screen readers
                width: 22, // Adjust width as needed
                height: 22, // Adjust height as needed
              ),
              const SizedBox(
                width: 4,
              ),
              TextWidget(
                title: AppLocalizations.of(context)!.continue_with_google,
                color: Colors.grey,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              )
            ]),
      ),
    );
  }
}
