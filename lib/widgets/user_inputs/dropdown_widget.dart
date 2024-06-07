import 'package:flutter/material.dart';
import 'package:flutter_challenge_mobile/providers/locale_provider.dart';
import 'package:flutter_challenge_mobile/widgets/general_widgets/text_widget.dart';
import 'package:provider/provider.dart';

class DropDownWidget extends StatelessWidget {
  final List items;
  final Function callback;
  final bool loading;
  final bool translation;
  final bool checkout;
  final dynamic initialValue;
  final bool show;
  const DropDownWidget(
      {super.key,
      required this.items,
      required this.callback,
      this.loading = false,
      this.translation = true,
      this.checkout = false,
      this.initialValue,
      required this.show});

  @override
  Widget build(BuildContext context) {
    return show
        ? DropdownButtonHideUnderline(
            child: DropdownButtonFormField(
                dropdownColor: Theme.of(context).splashColor,
                value: initialValue,
                decoration: InputDecoration(
                  enabled: !loading,
                  fillColor: Theme.of(context).splashColor,
                  focusColor: Colors.grey,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade600)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade600),
                  ),
                ),
                items: items
                    .map((item) => DropdownMenuItem(
                        value: item['value'],
                        child:
                            Provider.of<LocaleProvider>(context, listen: false)
                                        .locale ==
                                    'ar'
                                ? TextWidget(
                                    title: item['nameAr'],
                                    fontSize: 15,
                                  )
                                : TextWidget(
                                    title: item['nameEn'],
                                    fontSize: 15,
                                  )))
                    .toList(),
                onChanged: (value) => {callback(value)}),
          )
        : Container();
  }
}
