import 'package:flutter/material.dart';
import 'package:flutter_challenge_mobile/providers/locale_provider.dart';
import 'package:flutter_challenge_mobile/widgets/general_widgets/text_widget.dart';
import 'package:provider/provider.dart';

class DropDownById extends StatefulWidget {
  final List items;
  final Function callback;
  final String error;
  final bool loading;
  final String label;
  final bool translation;
  final bool checkout;
  final dynamic initialValue;
  const DropDownById({
    super.key,
    required this.items,
    required this.label,
    required this.callback,
    this.error = '',
    this.loading = false,
    this.translation = true,
    this.checkout = false,
    this.initialValue,
  });

  @override
  State<DropDownById> createState() => _DropDownByIdState();
}

class _DropDownByIdState extends State<DropDownById> {
  FocusNode myFocusNode = FocusNode();
  void _requestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(myFocusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField(
          value: widget.initialValue,
          onTap: _requestFocus,
          decoration: InputDecoration(
            enabled: !widget.loading,
            errorText: widget.error.isEmpty ? null : widget.error,
            errorStyle: const TextStyle(
              color: Colors.red,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.error.isNotEmpty
                      ? Colors.red
                      : myFocusNode.hasFocus
                          ? Theme.of(context).primaryColor
                          : Colors.grey),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
            label: Text(
              widget.label,
              style: const TextStyle(fontSize: 14),
            ),
            fillColor: Theme.of(context).primaryColor,
            border: const OutlineInputBorder(),
          ),
          items: widget.items
              .map((item) => DropdownMenuItem(
                  value: item['_id'],
                  child: TextWidget(
                      title: item[
                          Provider.of<LocaleProvider>(context, listen: false)
                                      .locale ==
                                  'en'
                              ? 'name'
                              : 'nameAr'])))
              .toList(),
          onChanged: (value) => {widget.callback(value)}),
    );
  }
}
