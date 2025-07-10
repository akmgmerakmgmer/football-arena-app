import 'dart:math';
import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/screens/questions/user_image.dart';

class ProfileImages extends StatefulWidget {
  final bool isSelected;
  final String image;
  final dynamic video;
  final bool isTheme;
  final bool showVideo;
  final double height;
  final double width;
  final double radius;
  final bool transparentBorder;

  const ProfileImages({
    super.key,
    required this.isSelected,
    required this.image,
    this.isTheme = false,
    this.video,
    required this.showVideo,
    this.height = 110,
    this.width = 110,
    this.radius = 100,
    this.transparentBorder = true,
  });

  @override
  State<ProfileImages> createState() => _ProfileImagesState();
}

class _ProfileImagesState extends State<ProfileImages> {
  late final Color randomColor;

  static const List<Color> colorPalette = [
    Color(0xFFF06292),
    Color(0xFFBA68C8),
    Color(0xFF9575CD),
    Color(0xFF7986CB),
    Color(0xFF64B5F6),
    Color(0xFF4FC3F7),
    Color(0xFF4DD0E1),
    Color(0xFF4DB6AC),
    Color(0xFF81C784),
    Color(0xFFAED581),
    Color(0xFFFF8A65),
    Color(0xFFD4E157),
    Color(0xFFFFD54F),
    Color(0xFFFFB74D),
    Color(0xFFA1887F),
    Color(0xFF90A4AE),
    Color(0xFFCE93D8),
    Color(0xFFFFA726),
    Color(0xFFB0BEC5),
    Color(0xFF00B8D4),
    Color(0xFF00E676),
    Color(0xFFFFD600),
    Color(0xFFFF6D00),
    Color(0xFFAA00FF),
    Color(0xFF304FFE),
    Color(0xFF0091EA),
    Color(0xFF00BFAE),
    Color(0xFF64DD17),
    Color(0xFFC51162),
    Color(0xFFD50000),
    Color(0xFF6200EA),
    Color(0xFF2962FF),
    Color(0xFF00C853),
    Color(0xFFFFAB00),
    Color(0xFFB388FF),
    Color(0xFF8C9EFF),
  ];

  @override
  void initState() {
    super.initState();
    randomColor = colorPalette[Random().nextInt(colorPalette.length)];
  }

  @override
  Widget build(BuildContext context) {
    final neonColor = widget.isSelected
        ? Theme.of(context).primaryColor
        : widget.transparentBorder
            ? Colors.transparent
            : randomColor;

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
          border: Border.all(
            width: 3,
            color: neonColor,
          ),
        ),
        child: UserImage(
          image: widget.image,
          width: widget.width,
          height: widget.height,
          radius: widget.radius,
          video: widget.video,
          showVideo: widget.showVideo,
        ),
      ),
    );
  }
}
