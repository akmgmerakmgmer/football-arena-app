import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/generalMethods.dart';
import 'package:in_zone_app/widgets/buttons/purchase_button.dart';

class CoinsButton extends StatefulWidget {
  final String mode;
  final LocaleProvider localeProvider;
  final bool isOnline;
  final dynamic callback;
  final String buttonText;
  final bool hostRoom;
  final bool isCasual;
  const CoinsButton(
      {super.key,
      required this.mode,
      required this.localeProvider,
      this.isOnline = false,
      this.callback,
      this.buttonText = '',
      this.hostRoom = false,
      this.isCasual = false});

  @override
  State<CoinsButton> createState() => _CoinsButtonState();
}

class _CoinsButtonState extends State<CoinsButton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PurchaseButton(
          buttonText: widget.buttonText,
          loading: loading,
          price: '100',
          action: () {
            if (context.mounted && !loading) {
              setState(() {
                loading = true;
              });
              GeneralMethods().playWithCoins(
                  context,
                  widget.localeProvider,
                  widget.mode,
                  widget.isOnline,
                  widget.hostRoom,
                  widget.isCasual);
            }
            if (widget.callback != null) {
              widget.callback();
            }
          }),
    );
  }
}
