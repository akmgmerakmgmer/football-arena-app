import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/utilities/auth.dart';
import 'package:in_zone_app/widgets/buttons/main_button.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/user_inputs/input.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupFormNoBirthdate extends StatefulWidget {
  const SignupFormNoBirthdate({super.key});

  @override
  State<SignupFormNoBirthdate> createState() => _SignupFormNoBirthdateState();
}

class _SignupFormNoBirthdateState extends State<SignupFormNoBirthdate> {
  bool loading = false;
  Map payload = {'username': '', 'password': '', 'number': ''};
  Map errors = {'username': '', 'number': '', 'password': ''};

  Future<void> signupMethod() async {
    setState(() {
      loading = true;
      errors = {'username': '', 'number': '', 'password': ''};
    });
    PostApi('signup', payload,
        successMessage: AppLocalizations.of(context)!.user_created,
        (response) async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', response['accessToken']);
      String? token = localStorage.getString(('token'));
      // ignore: use_build_context_synchronously
      await Auth().getUser(token, context);
      setState(() {
        loading = false;
      });
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/');
    }, errorCallback: (value) {
      if (value.containsKey('username') &&
          value['username'] == 'field_required') {
        errors['username'] = AppLocalizations.of(context)!.field_required;
      }
      if (value.containsKey('username') &&
          value['username'] == 'username_unique') {
        errors['username'] = AppLocalizations.of(context)!.username_unique;
      }
      if (value.containsKey('username') &&
          value['username'] == 'username_min_length') {
        errors['username'] = AppLocalizations.of(context)!.username_min_length;
      }
      if (value.containsKey('number') && value['number'] == 'field_required') {
        errors['number'] = AppLocalizations.of(context)!.field_required;
      }
      if (value.containsKey('number') &&
          value['number'] == 'number_min_length') {
        errors['number'] = AppLocalizations.of(context)!.number_min_length;
      }
      if (value.containsKey('password') &&
          value['password'] == 'field_required') {
        errors['password'] = AppLocalizations.of(context)!.field_required;
      }
      if (value.containsKey('password') &&
          value['password'] == 'password_min_length') {
        errors['password'] = AppLocalizations.of(context)!.password_min_length;
      }
      setState(() {
        loading = false;
      });
    }).post(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 15,
        ),
        Input(
          callback: (value) {
            payload['username'] = value;
          },
          error: errors['username'],
          label: AppLocalizations.of(context)!.username,
          loading: loading,
          icon: const Icon(Icons.person_outlined),
        ),
        const SizedBox(
          height: 15,
        ),
        Input(
          callback: (value) {
            payload['password'] = value;
          },
          error: errors['password'],
          label: AppLocalizations.of(context)!.password,
          loading: loading,
          isPassword: true,
          icon: const Icon(Icons.lock_outlined),
        ),
        const SizedBox(
          height: 15,
        ),
        Input(
          callback: (value) {
            payload['number'] = value;
          },
          error: errors['number'],
          label: AppLocalizations.of(context)!.number,
          loading: loading,
          type: TextInputType.number,
          icon: const Icon(Icons.phone_outlined),
        ),
        const SizedBox(
          height: 18,
        ),
        // Enhanced Signup Button with glow
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: Colors.purple.withOpacity(0.4),
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
          ),
          child: MainButton(
            buttonText: '🎯 ${AppLocalizations.of(context)!.createAccount}',
            uppercase: true,
            loading: loading,
            action: signupMethod,
            fontSize: 16,
            radius: 100,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🏆', style: TextStyle(fontSize: 14)),
                  const SizedBox(width: 6),
                  TextWidget(
                    title: AppLocalizations.of(context)!.alreadyHaveAnAccount,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
