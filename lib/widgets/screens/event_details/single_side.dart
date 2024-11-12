import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class SingleSide extends StatelessWidget {
  final String title;
  final bool selected;
  const SingleSide({super.key, required this.title, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              boxShadow: selected
                  ? const [
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
                    ]
                  : null,
              color: selected
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).primaryColorDark,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          padding: const EdgeInsets.all(16),
          child: TextWidget(
            title: title,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 16,
        )
      ],
    );
  }
}
