import 'package:flutter/material.dart';
import 'package:flutter_challenge_mobile/providers/locale_provider.dart';
import 'package:flutter_challenge_mobile/utilities/auth.dart';
import 'package:flutter_challenge_mobile/widgets/drawer/drawer_widget.dart';
import 'package:flutter_challenge_mobile/widgets/footer/footer.dart';
import 'package:flutter_challenge_mobile/widgets/loadings/primary_loading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageContainerWithFooter extends StatefulWidget {
  final Widget body;
  final Color background;
  const PageContainerWithFooter(
      {super.key, required this.body, this.background = Colors.transparent});

  @override
  State<PageContainerWithFooter> createState() =>
      _PageContainerWithFooterState();
}

class _PageContainerWithFooterState extends State<PageContainerWithFooter> {
  bool loading = false;
  void getLocale() async {
    if (Provider.of<LocaleProvider>(context, listen: false).locale == '') {
      SharedPreferences locale = await SharedPreferences.getInstance();
      dynamic currentLocale = locale.getString('locale');
      // ignore: use_build_context_synchronously
      Provider.of<LocaleProvider>(context, listen: false)
          .changeLocale(currentLocale == 'en' ? 'en' : 'ar');
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
      setState(() {
        loading = true;
      });
      // ignore: use_build_context_synchronously
      await Auth().getUser(token, context);
      setState(() {
        loading = false;
      });
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
        endDrawer: const DrawerWidget(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBar(
            iconTheme: IconThemeData(color: Colors.grey.shade400),
            automaticallyImplyLeading: false,
            title: GestureDetector(
              onTap: () => {Navigator.pushNamed(context, '/')},
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
                width: 55,
              ),
            ),
            elevation: 0, // Remove AppBar shadow
            backgroundColor: const Color(0xFF191919),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
          color: widget.background,
          child: loading
              ? Container(
                  height: MediaQuery.of(context).size.height - 56,
                  color: Theme.of(context).splashColor,
                  child: const PrimaryLoading())
              : Column(
                  children: [
                    ConstrainedBox(
                        constraints: BoxConstraints(
                            minHeight:
                                MediaQuery.of(context).size.height - 200),
                        child: widget.body),
                    const Footer()
                  ],
                ),
        )),
      ),
    );
  }
}
