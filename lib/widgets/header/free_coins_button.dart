import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/ad_methods.dart';
import 'package:in_zone_app/utilities/ad_reward_methods.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';

class FreeCoinsButton extends StatefulWidget {
  final LocaleProvider localeProvider;
  final String locale;
  
  const FreeCoinsButton({
    super.key,
    required this.localeProvider,
    required this.locale,
  });

  @override
  State<FreeCoinsButton> createState() => _FreeCoinsButtonState();
}

class _FreeCoinsButtonState extends State<FreeCoinsButton> with SingleTickerProviderStateMixin {
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
    
    _bounceAnimation = Tween<double>(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(
        parent: _bounceController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  void _claimFreeCoins(BuildContext context) {
    if (AddRewardMethods().isFreeCoinsAvailable(widget.localeProvider, context)) {
      AdMethods().showInterstitialAd(() {
        Future.delayed(const Duration(seconds: 3), () {
          AddRewardMethods().addCoinsMethod(widget.localeProvider, context);
        });
      }, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isAvailable = AddRewardMethods().isFreeCoinsAvailable(widget.localeProvider, context);
    
    return GestureDetector(
      onTap: () => _claimFreeCoins(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isAvailable
                ? [
                    Colors.amber.shade600,
                    Colors.orange.shade600,
                  ]
                : [
                    Colors.grey.shade700,
                    Colors.grey.shade800,
                  ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isAvailable
                ? Colors.amber.shade300.withOpacity(0.5)
                : Colors.grey.shade600,
            width: 1.5,
          ),
          boxShadow: isAvailable
              ? [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.4),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Video icon with animation
            AnimatedBuilder(
              animation: _bounceAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: isAvailable 
                      ? Offset(0, -_bounceAnimation.value)
                      : Offset.zero,
                  child: Image.asset(
                    'assets/images/video_ad.png',
                    width: 24,
                    height: 24,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
            
            const SizedBox(width: 6),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextWidget(
                  title: AppLocalizations.of(context)!.coinAd,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                if (isAvailable)
                  Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Colors.greenAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      TextWidget(
                        title: widget.locale == 'en' ? 'Available' : 'متاح',
                        fontSize: 9,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
              ],
            ),
            
            // Badge indicator
            if (isAvailable) ...[
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 12,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
