import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/utilities/auth.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:in_zone_app/widgets/loadings/primary_loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class GoogleButton extends StatefulWidget {
  const GoogleButton({super.key});

  @override
  State<GoogleButton> createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  String displayName = '';
  bool loading = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/user.birthday.read',
      'https://www.googleapis.com/auth/userinfo.profile',
      'https://www.googleapis.com/auth/user.phonenumbers.read',
    ],
  );

  Future<Map<String, String?>> _getUserDetails(String accessToken) async {
    try {
      final response = await http.get(
        Uri.parse('https://people.googleapis.com/v1/people/me?personFields=birthdays,phoneNumbers'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      String? birthdate;
      String? phoneNumber;

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        // Extract birthdate
        if (data['birthdays'] != null && data['birthdays'].isNotEmpty) {
          final birthday = data['birthdays'][0]['date'];
          birthdate = '${birthday['year']}-${birthday['month']}-${birthday['day']}';
        }

        // Extract phone number
        if (data['phoneNumbers'] != null && data['phoneNumbers'].isNotEmpty) {
          phoneNumber = data['phoneNumbers'][0]['value'];
        }
      }

      return {
        'birthdate': birthdate,
        'phoneNumber': phoneNumber,
      };
    } catch (e) {
      return {
        'birthdate': null,
        'phoneNumber': null,
      };
    }
  }

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

      // Get the auth tokens
      final GoogleSignInAuthentication googleAuth = await selectedGoogleUser.authentication;
      
      // Get user details using the access token
      final Map<String, String?> userDetails = await _getUserDetails(googleAuth.accessToken ?? '');

      // Call your backend API for login with email, birthdate, and phone number
      PostApi('email-login', {
        'email': selectedGoogleUser.email,
        'birthdate': userDetails['birthdate'],
        'phoneNumber': userDetails['phoneNumber'],
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
                      semanticsLabel:
                          'Google Icon', // Optional, for screen readers
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
