import 'package:flutter/cupertino.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class ResultsData extends StatelessWidget {
  final String title;
  final String result;
  const ResultsData({super.key, required this.title, required this.result});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          TextWidget(
            title: title,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(
            height: 8,
          ),
          TextWidget(
            title: result,
            fontSize: 16,
            alwaysEnglish: true,
          )
        ],
      ),
    );
  }
}
