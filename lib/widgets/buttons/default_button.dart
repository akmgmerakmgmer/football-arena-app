import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/neon_box_shadow.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/loadings/primary_loading.dart';

class DefaultButton extends StatelessWidget {
  final String buttonText;
  final Function action;
  final bool loading;
  final Widget iconNext;
  final bool isThereIconNext;
  const DefaultButton(
      {super.key,
      required this.buttonText,
      required this.action,
      this.loading = false,
      this.iconNext = const SizedBox(),
      this.isThereIconNext = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => action(),
      child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: NeonBoxShadow().boxShadowNeon(context)),
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              loading
                  ? Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        child: const Center(
                            child: PrimaryLoading(
                          size: 10,
                        )),
                      ))
                  : Container(),
              Align(
                alignment: Alignment.center,
                child: Opacity(
                  opacity: loading ? 0 : 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidget(
                        title: buttonText,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      isThereIconNext
                          ? const SizedBox(
                              width: 3,
                            )
                          : const SizedBox(),
                      iconNext
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
