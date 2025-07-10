import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/general_widgets/asset_image_widget.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:provider/provider.dart';

class DropDownWidget extends StatelessWidget {
  final List items;
  final Function callback;
  final bool loading;
  final bool translation;
  final bool checkout;
  final dynamic initialValue;
  final bool show;
  final String label;
  const DropDownWidget(
      {super.key,
      required this.items,
      required this.callback,
      this.loading = false,
      this.translation = true,
      this.checkout = false,
      this.initialValue,
      this.show = true,
      this.label = ''});

  @override
  Widget build(BuildContext context) {
    String locale = Provider.of<LocaleProvider>(context, listen: false).locale;
    return show
        ? Column(
            children: [
              DropdownButtonHideUnderline(
                child: DropdownButtonFormField(
                    dropdownColor: Theme.of(context).splashColor,
                    value: initialValue,
                    decoration: InputDecoration(
                      labelText: label,
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontFamily:
                              locale == 'en' ? 'Oswald' : 'NotoKufiArabic'),
                      enabled: !loading,
                      fillColor: Theme.of(context).splashColor,
                      focusColor: Colors.grey,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey.shade600, width: 2)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey.shade600, width: 2)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.shade600, width: 2),
                      ),
                    ),
                    items: items
                        .map((item) => DropdownMenuItem(
                            value: (item is String || item is num)
                                ? item
                                : item['value'],
                            child: Row(
                              children: [
                                item is Map &&
                                        (item['image'] ?? '')
                                            .toString()
                                            .isNotEmpty
                                    ? AssetImageWidget(
                                        image: item['image'],
                                        radius: 100,
                                        width: 30,
                                        height: 30,
                                      )
                                    : Container(),
                                item is Map &&
                                        (item['image'] ?? '')
                                            .toString()
                                            .isNotEmpty
                                    ? const SizedBox(
                                        width: 10,
                                      )
                                    : Container(),
                                (item is String || item is num)
                                    ? TextWidget(
                                        title: item.toString(),
                                        fontSize: 15,
                                      )
                                    : locale == 'ar'
                                        ? TextWidget(
                                            title: item['nameAr'] ?? item['ar'],
                                            fontSize: 15,
                                          )
                                        : TextWidget(
                                            title: item['nameEn'] ?? item['en'],
                                            fontSize: 15,
                                          )
                              ],
                            )))
                        .toList(),
                    onChanged: (value) => {callback(value)}),
              ),
              const SizedBox(
                height: 12,
              )
            ],
          )
        : Container();
  }
}
