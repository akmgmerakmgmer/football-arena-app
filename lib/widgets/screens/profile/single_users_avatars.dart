import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/screens/profile/profile_button.dart';
import 'package:in_zone_app/widgets/screens/profile/profile_images.dart';

class SingleUsersAvatars extends StatelessWidget {
  final LocaleProvider localeProvider;
  final Map body;
  final String userId;
  final bool isSelected;
  final String image;
  final bool isTheme;
  final dynamic video;
  final bool showVideo;
  const SingleUsersAvatars({
    super.key,
    required this.body,
    required this.userId,
    required this.localeProvider,
    required this.isSelected,
    required this.image,
    required this.isTheme,
    this.video,
    required this.showVideo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ProfileImages(
            isSelected: isSelected,
            image: image,
            isTheme: isTheme,
            video: video,
            showVideo: showVideo,
          ),
          ProfileButton(
              isTheme: isTheme,
              isSelected: isSelected,
              userId: userId,
              body: body,
              localeProvider: localeProvider)
        ],
      ),
    );
  }
}
