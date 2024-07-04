import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/utilities/auth.dart';
import 'package:in_zone_app/widgets/buttons/main_button.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/user_inputs/input.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
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
      Navigator.pushReplacementNamed(context, '/');
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
          height: 15,
        ),
        MainButton(
          buttonText: AppLocalizations.of(context)!.createAccount,
          uppercase: true,
          loading: loading,
          action: signupMethod,
          fontSize: 16,
          radius: 100,
        ),
        const SizedBox(
          height: 7,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
          child: TextWidget(
              title: AppLocalizations.of(context)!.alreadyHaveAnAccount),
        )
      ],
    );
  }
}
