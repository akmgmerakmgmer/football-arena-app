import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/containers/username_text.dart';
import 'package:provider/provider.dart';

class Input extends StatefulWidget {
  final Function callback;
  final String label;
  final TextInputType type;
  final String value;
  final dynamic error;
  final bool loading;
  final bool disabled;
  final bool isPassword;
  final int maxLines;
  final Widget icon;
  const Input(
      {super.key,
      required this.callback,
      required this.label,
      this.type = TextInputType.text,
      this.value = '',
      this.error = '',
      this.loading = false,
      this.disabled = false,
      this.isPassword = false,
      this.maxLines = 1,
      required this.icon});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
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
      maxLines: widget.maxLines,
      obscureText: widget.isPassword,
      enabled: !widget.disabled && !widget.loading,
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
        suffixIcon: widget.icon,
        suffixIconColor: Colors.white,
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(100)),
        alignLabelWithHint: true,
        enabled: !widget.disabled && !widget.loading,
        errorText: widget.error.isEmpty ? null : widget.error,
        errorStyle: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          letterSpacing:
              Provider.of<LocaleProvider>(context, listen: false).locale == 'ar'
                  ? 0
                  : 0.2,
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          borderSide: BorderSide(
            color: widget.error.isNotEmpty
                ? Colors.red
                : myFocusNode.hasFocus
                    ? Colors.white
                    : Colors.white,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        label: UsernameText(
          title: widget.label,
          fontSize: 14,
        ),
        labelStyle: const TextStyle(color: Colors.white),
        fillColor: Colors.white,
      ),
      cursorColor: Colors.white,
    );
  }
}
