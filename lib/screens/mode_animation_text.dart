import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/neon_white_text.dart';

class ModeAnimationText extends StatefulWidget {
  final String text;
  final double fontSize;
  final Duration stayDuration;
  
  const ModeAnimationText({
    super.key,
    required this.text,
    this.fontSize = 80, // Default font size that can be overridden
    this.stayDuration = const Duration(milliseconds: 800), // Time to stay visible before fade-out
  });

  @override
  State<ModeAnimationText> createState() => _ModeAnimationTextState();
}

class _ModeAnimationTextState extends State<ModeAnimationText>
    with SingleTickerProviderStateMixin {
  late List<bool> _visible;
  late List<String> _words;
  late int _totalCharacters;
  bool _fadeOutStarted = false;

  @override
  void initState() {
    super.initState();
    // Split the text into words
    _words = widget.text.split(' ');
    // Count total characters including spaces for animation timing
    _totalCharacters = widget.text.length;
    // Create visibility array for all characters
    _visible = List<bool>.filled(_totalCharacters, false);
    _triggerAnimations();
  }

  void _triggerAnimations() {
    int characterCount = 0;
    const fadeInDelay = 150; // milliseconds per character for fade-in

    // Fade-in animation for each character
    for (int i = 0; i < _totalCharacters; i++) {
      Future.delayed(Duration(milliseconds: i * fadeInDelay), () {
        if (mounted) {
          setState(() {
            if (characterCount < _visible.length) {
              _visible[characterCount] = true;
              characterCount++;
            }
          });
        }
      });
    }

    // After all characters have appeared and stayed visible for the specified duration,
    // trigger the fade-out animation
    final totalFadeInTime = _totalCharacters * fadeInDelay;
    Future.delayed(Duration(milliseconds: totalFadeInTime) + widget.stayDuration, () {
      _startFadeOut();
    });
  }

  void _startFadeOut() {
    if (!mounted || _fadeOutStarted) return;
    
    _fadeOutStarted = true;
    const fadeOutDelay = 150; // milliseconds per character for fade-out
    
    // Fade-out from the last character to the first (last out, first in)
    for (int i = 0; i < _totalCharacters; i++) {
      // Calculate the reverse index to animate from last to first
      int reverseIndex = _totalCharacters - 1 - i;
      
      Future.delayed(Duration(milliseconds: i * fadeOutDelay), () {
        if (mounted) {
          setState(() {
            if (reverseIndex >= 0 && reverseIndex < _visible.length) {
              _visible[reverseIndex] = false;
            }
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // Calculate an appropriate font size if needed
      final longestWord = _words.reduce((a, b) => a.length > b.length ? a : b);
      
      final textSpan = TextSpan(
        text: longestWord,
        style: TextStyle(
          fontFamily: 'Oswald',
          fontSize: widget.fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 2,
        ),
      );
      
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      )..layout();
      
      // Determine if we need to adjust the font size
      double finalFontSize = widget.fontSize;
      if (textPainter.width > constraints.maxWidth * 0.9) {
        // Scale down the font size to fit the available width
        finalFontSize =
            widget.fontSize * (constraints.maxWidth * 0.9) / textPainter.width;
        // Ensure font size doesn't get too small
        finalFontSize = finalFontSize.clamp(20.0, widget.fontSize);
      }
      
      // Build a column with each word on its own line
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildAnimatedWords(finalFontSize),
      );
    });
  }

  List<Widget> _buildAnimatedWords(double fontSize) {
    List<Widget> wordWidgets = [];
    int characterCounter = 0;
    
    for (int wordIndex = 0; wordIndex < _words.length; wordIndex++) {
      String word = _words[wordIndex];
      List<Widget> letterWidgets = [];
      
      for (int letterIndex = 0; letterIndex < word.length; letterIndex++) {
        if (characterCounter < _visible.length) {
          letterWidgets.add(AnimatedOpacity(
              opacity: _visible[characterCounter] ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 600),
              child: NeonWhiteText(word: word[letterIndex], fontSize: fontSize)));
          characterCounter++;
        }
      }
      
      // Add a row for this word
      wordWidgets.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: letterWidgets,
      ));
      
      // Count the space character for animation timing
      if (wordIndex < _words.length - 1) {
        characterCounter++;
      }
    }
    
    return wordWidgets;
  }
}