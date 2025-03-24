import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:provider/provider.dart';

class CodeInput extends StatefulWidget {
  final Function callback;
  final TextInputType type;
  final String value;
  final bool loading;
  const CodeInput({
    super.key,
    required this.callback,
    this.type = TextInputType.number,
    this.value = '',
    this.loading = false,
  });

  @override
  State<CodeInput> createState() => _InputState();
}

class _InputState extends State<CodeInput> {
  FocusNode myFocusNode = FocusNode();
  void _requestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(myFocusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.center,
      enabled: !widget.loading,
      focusNode: myFocusNode,
      onTap: _requestFocus,
      onChanged: (value) => widget.callback(value),
      initialValue: widget.value,
      keyboardType: widget.type,
      textDirection:
          Provider.of<LocaleProvider>(context, listen: false).locale == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily:
              Provider.of<LocaleProvider>(context, listen: false).locale == 'ar'
                  ? 'NotoKufiArabic'
                  : 'Oswald',
          fontSize: 14), // Set text color to white
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(100)),
        alignLabelWithHint: true,
        enabled: widget.loading,
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        fillColor: Colors.white,
      ),
      cursorColor: Colors.white,
    );
  }
}
