import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/white_glass_background.dart';
import 'package:in_zone_app/widgets/general_widgets/cached_image.dart';
import 'package:in_zone_app/widgets/general_widgets/username_text.dart';
import 'package:in_zone_app/widgets/screens/profile/profile_images.dart';

class PlayerPartyAvatar extends StatefulWidget {
  final Map player;
  final Map user;
  const PlayerPartyAvatar({
    super.key,
    required this.player,
    required this.user,
  });

  @override
  State<PlayerPartyAvatar> createState() => _PlayerPartyAvatarState();
}

class _PlayerPartyAvatarState extends State<PlayerPartyAvatar> with SingleTickerProviderStateMixin {
  late AnimationController _entranceController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    
    // Entrance animation
    _entranceController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _entranceController, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entranceController, curve: Curves.easeIn),
    );

    // Start entrance animation
    _entranceController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final avatar = widget.player['userId']['selectedAvatar'];
    final username = widget.player['userId']?['username'] ?? '';
    final rank = widget.player['userId']['rank'];
    final bool isCurrentUser = username == widget.user['username'];

    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: isCurrentUser
                ? LinearGradient(
                    colors: [
                      Colors.amber.withOpacity(0.3),
                      Colors.orange.withOpacity(0.2),
                    ],
                  )
                : null,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isCurrentUser
                  ? Colors.amber.withOpacity(0.8)
                  : Colors.white.withOpacity(0.1),
              width: isCurrentUser ? 3 : 1,
            ),
            boxShadow: isCurrentUser
                ? [
                    BoxShadow(
                      color: Colors.amber.withOpacity(0.4),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ProfileImages(
                    isSelected: isCurrentUser,
                    image: avatar['image'],
                    video: avatar['video'],
                    showVideo: avatar['video'] != '',
                    height: 90,
                    width: 90,
                  ),
                  // Rank badge overlay
                  if (rank != null)
                    Positioned(
                      bottom: -4,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.8),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.amber.withOpacity(0.6),
                              width: 2,
                            ),
                          ),
                          child: CachedImage(
                            image: rank['image'],
                            width: 28,
                            height: 28,
                          ),
                        ),
                      ),
                    ),
                  // Ready checkmark (top right)
                  Positioned(
                    top: -4,
                    right: -4,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.6),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                  // Current user indicator
                  if (isCurrentUser)
                    Positioned(
                      top: -8,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.amber.shade600, Colors.orange.shade600],
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.amber.withOpacity(0.5),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: const Text(
                            'YOU',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              username.isEmpty
                  ? Container()
                  : WhiteGlassBackground(
                      body: UsernameText(
                        title: username,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
