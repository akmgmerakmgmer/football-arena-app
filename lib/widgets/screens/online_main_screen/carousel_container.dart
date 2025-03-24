import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/title_with_border.dart';
import 'package:in_zone_app/widgets/screens/online_main_screen/carousel_item.dart';
import 'package:in_zone_app/widgets/screens/online_main_screen/container_body.dart';

class CarouselContainer extends StatelessWidget {
  final String title;
  final String desc;
  final List data;
  final String locale;
  const CarouselContainer(
      {super.key,
      required this.title,
      required this.data,
      required this.desc,
      required this.locale});

  @override
  Widget build(BuildContext context) {
    bool isTitleAndDescExists(item) {
      if (item.isNotEmpty && item.containsKey('title')) return true;
      return false;
    }

    return Column(
      children: [
        TitleWithBorder(title: title),
        const SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: data
                .map((item) => CarouselItem(
                      allDataLength: data.length,
                      item: item,
                      body: ContainerBody(
                        title: isTitleAndDescExists(item)
                            ? item['title'][locale]
                            : title,
                        desc: isTitleAndDescExists(item)
                            ? item['desc'][locale]
                            : desc,
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
