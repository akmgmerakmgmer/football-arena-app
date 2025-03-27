import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/media_query_height.dart';

class CarouselItem extends StatelessWidget {
  final int allDataLength;
  final Map item;
  final Widget body;
  const CarouselItem(
      {super.key,
      required this.allDataLength,
      required this.item,
      required this.body});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        item['action']();
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Container(
              alignment: Alignment.bottomCenter,
              height: MediaQueryHeight().largeImageHeight(context),
              width: allDataLength == 1
                  ? MediaQuery.of(context).size.width - 16
                  : MediaQuery.of(context).size.width - 60,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                      image: AssetImage(item['image']),
                      fit: BoxFit.cover)),
              child: body,
            ),
          ),
          const SizedBox(
            width: 12,
          )
        ],
      ),
    );
  }
}
