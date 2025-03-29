import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/generalMethods.dart';
import 'package:in_zone_app/utilities/socket_methods.dart';
import 'package:in_zone_app/widgets/buttons/main_button.dart';
import 'package:in_zone_app/widgets/general_widgets/snackbar_message.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CodeInputForm extends StatefulWidget {
  const CodeInputForm({super.key});

  @override
  State<CodeInputForm> createState() => _CodeInputFormState();
}

class _CodeInputFormState extends State<CodeInputForm> {
  bool loading = false;
  final List<TextEditingController> _controllers =
      List.generate(5, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(5, (index) => FocusNode());
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_focusNodes.isNotEmpty) {
          _focusNodes[0].requestFocus();
        }
      });
      LocaleProvider localeProvider =
          Provider.of<LocaleProvider>(context, listen: false);
      _socketMethods.joinRoomSuccesListener(context, localeProvider);
      _socketMethods.joinRoomErrorListener(context, localeProvider.locale, () {
        Navigator.pop(context);
        setState(() {
          loading = false;
        });
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void initialMethod() {}

  void _onChanged(String value, int index) {
    if (value.isNotEmpty && index < _controllers.length - 1) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
  }

  void joinMatch() {
    String code = _controllers.map((controller) => controller.text).join();
    if (code != '') {
      setState(() {
        loading = true;
      });
      LocaleProvider localeProvider =
          Provider.of<LocaleProvider>(context, listen: false);
      GeneralMethods().joinGameWithAds(context, localeProvider, code: code);
    } else {
      Navigator.of(context).pop();
      SnackbarMessage().snackbar(
          context, AppLocalizations.of(context)!.code_empty,
          error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return Expanded(
              child: Container(
                width: 50,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: TextFormField(
                  textDirection:
                      Provider.of<LocaleProvider>(context, listen: false)
                                  .locale ==
                              'en'
                          ? TextDirection.ltr
                          : TextDirection.rtl,
                  style: TextStyle(
                    color: Colors.grey.shade300,
                    fontWeight: FontWeight.bold,
                    fontFamily:
                        Provider.of<LocaleProvider>(context, listen: false)
                                    .locale ==
                                'ar'
                            ? 'NotoKufiArabic'
                            : 'Oswald',
                    fontSize: 12,
                  ),
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  maxLength: 1,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  onChanged: (value) => _onChanged(value, index),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignLabelWithHint: true,
                    enabled: !loading,
                    disabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Colors.red.shade500),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    fillColor: Colors.grey.shade300,
                    counterText: "", // Removes the character count text
                  ),
                  cursorColor: Colors.grey.shade300,
                ),
              ),
            );
          }),
        ),
        const SizedBox(
          height: 16,
        ),
        MainButton(
          buttonText: AppLocalizations.of(context)!.join_match,
          action: joinMatch,
          loading: loading,
          padding: const EdgeInsets.all(8),
          fontSize: 13,
          uppercase: true,
        )
      ],
    );
  }
}
