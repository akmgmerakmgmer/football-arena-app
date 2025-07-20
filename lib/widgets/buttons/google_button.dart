import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/utilities/auth.dart';
import 'package:in_zone_app/widgets/buttons/google_button_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:in_zone_app/widgets/user_inputs/input.dart';
import 'package:in_zone_app/widgets/general_widgets/dialog_widget_blured.dart';

// ignore: must_be_immutable
class GoogleButton extends StatefulWidget {
  const GoogleButton({super.key});

  @override
  State<GoogleButton> createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  String displayName = '';
  bool loading = false;

  DateTime? selectedDate;
  String? birthdateError;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _handleSignIn(context, String birthdate) async {
    try {
      setState(() {
        loading = true;
      });
      final GoogleSignInAccount? googleUser =
          await _googleSignIn.signInSilently();
      if (googleUser != null) {
        await _googleSignIn
            .disconnect(); // Disconnect the previous session to force account selection
      }

      // Ensure the Google Sign-In flow always prompts for account selection
      final GoogleSignInAccount? selectedGoogleUser =
          await _googleSignIn.signIn();
      if (selectedGoogleUser == null) {
        setState(() {
          loading = false;
        });
        return; // User canceled the sign-in
      }

      // Call your backend API for login
      PostApi('email-login', {
        'email': selectedGoogleUser.email,
        'birthdate': birthdate
      }, (res) async {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('token', res['accessToken']);
        String? token = localStorage.getString(('token'));

        // Retrieve user details and navigate to the home screen
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

  void _showBirthdateDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return DialogWidgetBlured(
              title: AppLocalizations.of(context)!.birthDate,
              widget: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate ?? DateTime(2000, 1, 1),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: Theme.of(context).primaryColor,
                                onPrimary: Colors.white,
                                onSurface: Colors.black,
                              ),
                              dialogBackgroundColor: Colors.white,
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (picked != null) {
                        setStateDialog(() {
                          selectedDate = picked;
                          birthdateError = null;
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: Input(
                        key: ValueKey(selectedDate),
                        callback: (_) {},
                        value: selectedDate != null
                            ? '${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}'
                            : '',
                        label: AppLocalizations.of(context)!.birthDate,
                        error: birthdateError ?? '',
                        loading: false,
                        disabled: true,
                        icon: const Icon(Icons.cake_outlined),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                      onTap: () {
                        if (selectedDate == null) {
                          setStateDialog(() {
                            birthdateError =
                                AppLocalizations.of(context)!.field_required;
                          });
                          return;
                        }
                        _handleSignIn(context,
                            '${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}');
                      },
                      child: GoogleButtonStyle(loading: loading)),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => _showBirthdateDialog(context),
        child: GoogleButtonStyle(loading: loading));
  }
}
