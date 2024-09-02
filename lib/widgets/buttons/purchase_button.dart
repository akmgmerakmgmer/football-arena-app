import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/loadings/primary_loading.dart';

class PurchaseButton extends StatelessWidget {
  final String buttonText;
  final Function action;
  final bool loading;
  final String price;
  const PurchaseButton({
    super.key,
    required this.buttonText,
    required this.action,
    this.loading = false,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => action(),
      child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFFDC2626),
                spreadRadius: 0,
                blurRadius: 5,
                offset: Offset(0, 0),
              ),
              BoxShadow(
                color: Color(0xFFDC2626),
                spreadRadius: 0,
                blurRadius: 5,
                offset: Offset(0, 0),
              ),
              BoxShadow(
                color: Color(0xFFDC2626),
                spreadRadius: 0,
                blurRadius: 5,
                offset: Offset(0, 0),
              ),
            ],
          ),
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              loading
                  ? Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        child: const Center(child: PrimaryLoading()),
                      ))
                  : Container(),
              Opacity(
                opacity: loading ? 0 : 1,
                child: Column(
                  children: [
                    TextWidget(
                      title: AppLocalizations.of(context)!.buyNow,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          title: price,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Image.asset(
                          'assets/images/coin.png',
                          width: 23,
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
