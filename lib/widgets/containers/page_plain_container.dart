import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/auth.dart';
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
      
      if (currentLocale == null) {
        // Get the device locale
        final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale.languageCode;
        final isArabic = deviceLocale == 'ar';
        currentLocale = isArabic ? 'ar' : 'en';
        // Save the locale preference
        locale.setString('locale', currentLocale);
      }
      
      // ignore: use_build_context_synchronously
      Provider.of<LocaleProvider>(context, listen: false)
          .changeLocale(currentLocale);
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
    // Get the padding values from MediaQuery
    EdgeInsets padding = MediaQuery.of(context).padding;

    // Get the total height of the screen
    double totalHeight = MediaQuery.of(context).size.height;

    // Calculate the height of the safe area
    double pageHeight = totalHeight - padding.top - padding.bottom;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Container(
                height: pageHeight,
                color: widget.background,
                child: widget.body)),
      ),
    );
  }
}
