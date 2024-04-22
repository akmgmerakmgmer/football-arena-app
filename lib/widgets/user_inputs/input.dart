import 'package:flutter/material.dart';
import 'package:flutter_challenge_mobile/providers/locale_provider.dart';
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
      this.maxLines = 1});

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
      style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14), // Set text color to white
      decoration: InputDecoration(
        alignLabelWithHint: true,
        enabled: !widget.disabled && !widget.loading,
        errorText: widget.error.isEmpty ? null : widget.error,
        errorStyle: const TextStyle(
          color: Colors.red,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          borderSide: BorderSide(
            color: Colors.grey.shade700,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          borderSide: BorderSide(
            color: widget.error.isNotEmpty
                ? Colors.red
                : myFocusNode.hasFocus
                    ? Colors.grey
                    : Colors.grey.shade300,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        label: Text(
          widget.label,
          style: TextStyle(
            fontSize: 14,
            fontFamily:
                Provider.of<LocaleProvider>(context, listen: false).locale ==
                        'ar'
                    ? 'NotoKufiArabic'
                    : 'Oswald',
          ),
        ),
        labelStyle: const TextStyle(color: Colors.grey),
        fillColor: Colors.grey,
      ),
      cursorColor: Colors.grey,
    );
  }
}
