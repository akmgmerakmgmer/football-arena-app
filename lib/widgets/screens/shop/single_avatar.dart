import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/widgets/containers/background_network_image.dart';
import 'package:in_zone_app/widgets/containers/background_network_video.dart';
import 'package:in_zone_app/widgets/general_widgets/snackbar_message.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/screens/shop/single_avatar_data.dart';
import 'package:provider/provider.dart';

class SingleAvatar extends StatefulWidget {
  final Map avatar;
  const SingleAvatar({
    super.key,
    required this.avatar,
  });

  @override
  State<SingleAvatar> createState() => _SingleAvatarState();
}

class _SingleAvatarState extends State<SingleAvatar> {
  bool loading = false;
  Future<void> onClick() async {
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    if (user.isEmpty) {
      Navigator.pushNamed(context, '/signup');
    } else {
      setState(() {
        loading = true;
      });
      PutApi('buy-avatar/${user['_id']}', {"avatar": widget.avatar}, (res) {
        Provider.of<LocaleProvider>(context, listen: false)
            .setUser(res['user']);
        SnackbarMessage().snackbar(
            context, AppLocalizations.of(context)!.congratsAvatar,
            label: AppLocalizations.of(context)!.checkYourAccount, action: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          Navigator.pushNamed(context, '/profile');
        });
        setState(() {
          loading = false;
        });
      }, errorCallback: (err) {
        String message =
            Provider.of<LocaleProvider>(context, listen: false).locale == 'ar'
                ? err['message']['ar']
                : err['message']['en'];
        SnackbarMessage().snackbar(context, message, error: true);
        setState(() {
          loading = false;
        });
      }).put(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final Uri videoUrl = widget.avatar['video'] != null
        ? Uri.parse("${widget.avatar['video']}")
        : Uri.parse('');
    return widget.avatar['video'] != null
        ? BackgroundNetworkVideo(
            videoUrl: videoUrl,
            body: SingleAvatarData(
                width: width,
                avatar: widget.avatar,
                action: () {
                  onClick();
                },
                loading: loading))
        : BackgroundNetworkImage(
            image: widget.avatar['image'],
            body: SingleAvatarData(
                width: width,
                avatar: widget.avatar,
                action: () {
                  onClick();
                },
                loading: loading));
  }
}
