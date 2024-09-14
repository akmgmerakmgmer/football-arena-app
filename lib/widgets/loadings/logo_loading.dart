import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/fade_transition.dart';

class LogoLoading extends StatefulWidget {
  final bool isVisible;
  const LogoLoading({super.key, required this.isVisible});

  @override
  // ignore: library_private_types_in_public_api
  _LogoLoadingState createState() => _LogoLoadingState();
}

class _LogoLoadingState extends State<LogoLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Create an animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Adjust the speed of the scaling
    )..repeat(reverse: true); // Makes the animation repeat forever in a loop

    // Define a scaling animation
    _animation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller
        .dispose(); // Dispose of the controller when the widget is destroyed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransitionContainer(
      isVisible: widget.isVisible,
      duration: const Duration(milliseconds: 0),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).splashColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ScaleTransition(
                scale: _animation, // Apply the scaling animation
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                  width: 175,
                )),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: LinearProgressIndicator(
                  color: Theme.of(context).primaryColor,
                  backgroundColor: Colors.transparent,
                ))
          ],
        ),
      ),
    );
  }
}
