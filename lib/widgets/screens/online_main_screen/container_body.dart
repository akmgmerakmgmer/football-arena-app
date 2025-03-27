import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/containers/white_glass_background.dart';

class ContainerBody extends StatelessWidget {
  final String title;
  final String desc;
  const ContainerBody({super.key, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          WhiteGlassBackground(
            darkenBackground: true,
            body: TextWidget(
              title: title,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          TextWidget(
            title: desc,
            color: Colors.grey.shade300,
            fontWeight: FontWeight.w600,
            fontSize: 12.5,
          ),
        ],
      ),
    );
  }
}
