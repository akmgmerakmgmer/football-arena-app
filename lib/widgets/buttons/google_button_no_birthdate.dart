import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/utilities/auth.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:in_zone_app/widgets/loadings/primary_loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleButtonNoBirthdate extends StatefulWidget {
  const GoogleButtonNoBirthdate({super.key});

  @override
  State<GoogleButtonNoBirthdate> createState() => _GoogleButtonNoBirthdateState();
}

class _GoogleButtonNoBirthdateState extends State<GoogleButtonNoBirthdate> {
  bool loading = false;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _handleSignIn(context) async {
    try {
      setState(() {
        loading = true;
      });
      final GoogleSignInAccount? googleUser = await _googleSignIn.signInSilently();
      if (googleUser != null) {
        await _googleSignIn.disconnect();
      }
      final GoogleSignInAccount? selectedGoogleUser = await _googleSignIn.signIn();
      if (selectedGoogleUser == null) {
        setState(() {
          loading = false;
        });
        return;
      }
      // Call your backend API for login
      PostApi('email-login', {
        'email': selectedGoogleUser.email,
      }, (res) async {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('token', res['accessToken']);
        String? token = localStorage.getString(('token'));
        await Auth().getUser(token, context);
        setState(() {
          loading = false;
        });
        Navigator.pushReplacementNamed(context, '/');
      }).post(context);
    } catch (error) {
      setState(() {
        loading = false;
      });
      print('Error signing in: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleSignIn(context),
      child: Container(
        padding: loading ? const EdgeInsets.all(12) : const EdgeInsets.all(8),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.white,
                Colors.white,
                Colors.white.withOpacity(0.75),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(4))),
        child: loading
            ? PrimaryLoading(
                color: Theme.of(context).primaryColor,
                size: 14,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    SvgPicture.asset(
                      'assets/images/icons8-google.svg',
                      semanticsLabel: 'Google Icon',
                      width: 22,
                      height: 22,
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
