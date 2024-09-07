import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/widgets/buttons/main_button.dart';
import 'package:in_zone_app/widgets/general_widgets/cached_image.dart';

class SingleUsersAvatars extends StatefulWidget {
  final bool isSelected;
  final String image;
  final String buttonText;
  final bool isWidget;
  final dynamic widget;
  final String api;
  final Map body;
  final Function callback;
  final Function errorCallback;
  const SingleUsersAvatars({
    super.key,
    required this.isSelected,
    required this.image,
    required this.buttonText,
    this.isWidget = false,
    this.widget,
    required this.api,
    required this.body,
    required this.callback,
    required this.errorCallback,
  });

  @override
  State<SingleUsersAvatars> createState() => _SingleUsersAvatarsState();
}

class _SingleUsersAvatarsState extends State<SingleUsersAvatars> {
  bool loading = false;
  Future<void> onClick() async {
    setState(() {
      loading = true;
    });
    PutApi(widget.api, widget.body, (res) {
      widget.callback(res);
      setState(() {
        loading = false;
      });
    }, errorCallback: (err) {
      widget.errorCallback(err);
      setState(() {
        loading = false;
      });
    }).put(context);
  }

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
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: Border.all(
                      width: 3,
                      color: widget.isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.transparent)),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: CachedImage(
                  image: widget.image,
                  width: 260,
                  height: 180,
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 15,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  constraints: const BoxConstraints(maxWidth: 200),
                  child: MainButton(
                    buttonText: widget.buttonText,
                    isWidget: widget.isWidget,
                    widget: widget.widget,
                    action: () {
                      onClick();
                    },
                    radius: 10,
                    fontSize: 13,
                    uppercase: true,
                    letterSpacing: 1.5,
                    loading: loading,
                  )))
        ],
      ),
    );
  }
}
