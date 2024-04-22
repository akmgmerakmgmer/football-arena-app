import 'package:flutter/material.dart';
import 'package:flutter_challenge_mobile/utilities/api_methods.dart';
import 'package:flutter_challenge_mobile/widgets/buttons/main_button.dart';

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
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(
                    width: 3,
                    color: widget.isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.transparent)),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: Image.network(
                widget.image,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: 220,
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
