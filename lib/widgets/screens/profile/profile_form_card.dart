import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/buttons/default_button.dart';
import 'package:in_zone_app/widgets/general_widgets/snackbar_message.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/user_inputs/input.dart';

class ProfileFormCard extends StatefulWidget {
  final Map user;
  final Function setUser;
  const ProfileFormCard({super.key, required this.user, required this.setUser});

  @override
  State<ProfileFormCard> createState() => _ProfileFormCardState();
}

class _ProfileFormCardState extends State<ProfileFormCard> {
  Map payload = {'username': '', 'number': ''};
  Map errors = {'username': '', 'number': ''};
  bool loading = false;
  
  Future<void> editUser(context) async {
    setState(() {
      errors = {'username': '', 'number': ''};
      loading = true;
    });
    if (payload['number'].length.toString() != '11') {
      setState(() {
        errors['number'] = AppLocalizations.of(context)!.number_min_length;
        loading = false;
      });
    } else {
      PutApi('users/${widget.user['_id']}', payload, (response) {
        widget.setUser(response);
        setState(() {
          loading = false;
        });
        SnackbarMessage()
            .snackbar(context, AppLocalizations.of(context)!.account_edited);
      }, errorCallback: (error) {
        setState(() {
          loading = false;
        });
        if (error['message'] == 'username_unique') {
          errors['username'] = AppLocalizations.of(context)!.username_unique;
        }
      }).put(context);
    }
  }

  @override
  void initState() {
    payload['username'] = widget.user['username'];
    payload['number'] = widget.user['number'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.black.withOpacity(0.4),
            Colors.black.withOpacity(0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Row(
            children: [
              Icon(
                Icons.edit_note,
                color: Theme.of(context).primaryColor,
                size: 24,
              ),
              const SizedBox(width: 8),
              TextWidget(
                title: AppLocalizations.of(context)!.edit,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Form Fields
          Input(
            callback: (value) {
              payload['username'] = value;
            },
            label: AppLocalizations.of(context)!.username,
            value: widget.user['username'],
            error: errors['username'],
            icon: const Icon(Icons.person_outlined),
          ),
          const SizedBox(height: 15),
          
          Input(
            callback: (value) {
              payload['number'] = value;
            },
            label: AppLocalizations.of(context)!.number,
            value: widget.user['number'],
            error: errors['number'],
            icon: const Icon(Icons.phone_outlined),
          ),
          const SizedBox(height: 15),
          
          DefaultButton(
            loading: loading,
            isThereIconNext: true,
            iconNext: const Icon(
              Icons.check_circle,
              size: 18,
              color: Colors.white,
            ),
            buttonText: AppLocalizations.of(context)!.edit,
            action: () {
              editUser(context);
            },
          ),
        ],
      ),
    );
  }
}
