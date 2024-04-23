import 'package:flutter/material.dart';
import 'package:flutter_challenge_mobile/providers/locale_provider.dart';
import 'package:flutter_challenge_mobile/utilities/auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PagePlainContainer extends StatefulWidget {
  final Widget body;
  final Color background;
  const PagePlainContainer(
      {super.key, required this.body, this.background = Colors.transparent});

  @override
  State<PagePlainContainer> createState() => _PagePlainContainerState();
}

class _PagePlainContainerState extends State<PagePlainContainer> {
  void getLocale() async {
    if (Provider.of<LocaleProvider>(context, listen: false).locale == '') {
      SharedPreferences locale = await SharedPreferences.getInstance();
      dynamic currentLocale = locale.getString('locale');
      // ignore: use_build_context_synchronously
      Provider.of<LocaleProvider>(context, listen: false)
          .changeLocale(currentLocale == 'ar' ? 'ar' : 'en');
    }
  }

  Future<void> getUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? token = localStorage.getString(('token'));
    if (token!.isNotEmpty &&
        // ignore: use_build_context_synchronously
        !Provider.of<LocaleProvider>(context, listen: false)
            .user
            .containsKey('username')) {
      // ignore: use_build_context_synchronously
      await Auth().getUser(token, context);
    }
  }

  @override
  void initState() {
    getLocale();
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: widget.background,
                child: widget.body)),
      ),
    );
  }
}
