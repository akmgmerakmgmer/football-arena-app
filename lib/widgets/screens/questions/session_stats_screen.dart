import 'package:flutter/material.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

/// Session statistics data holder
class SessionStats {
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;
  final int bestStreak;
  final double averageSpeed; // in seconds
  final int totalPoints;
  final int speedBonuses;

  SessionStats({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.bestStreak,
    required this.averageSpeed,
    required this.totalPoints,
    required this.speedBonuses,
  });

  double get accuracy => totalQuestions > 0 
      ? (correctAnswers / totalQuestions) * 100 
      : 0.0;

  String get accuracyText => '${accuracy.toStringAsFixed(1)}%';
  
  String get averageSpeedText => '${averageSpeed.toStringAsFixed(1)}s';
}

/// Beautiful session stats display screen shown at the end of a game session
/// Shows detailed performance metrics with animations
/// 
/// Performance considerations:
/// - Stats calculated once and passed in, no recalculation
/// - Uses const constructors where possible
/// - Animations only on entry, no continuous animations
class SessionStatsScreen extends StatefulWidget {
  final SessionStats stats;
  final VoidCallback onContinue;
  final String gameMode;

  const SessionStatsScreen({
    Key? key,
    required this.stats,
    required this.onContinue,
    required this.gameMode,
  }) : super(key: key);

  @override
  State<SessionStatsScreen> createState() => _SessionStatsScreenState();
}

class _SessionStatsScreenState extends State<SessionStatsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final localizations = AppLocalizations.of(context)!;
    
    return SizedBox(
      height: screenHeight,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade900,
              Colors.purple.shade900,
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    // Title
                    const Icon(
                      Icons.emoji_events,
                      size: 60,
                      color: Colors.amber,
                    ),
                    const SizedBox(height: 12),
                  TextWidget(
                    title: localizations.session_complete,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 6),
                  TextWidget(
                    title: widget.gameMode.isEmpty ? localizations.practice_mode : widget.gameMode,
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                  const SizedBox(height: 20),

                  // Stats Container
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        // Main Stats Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatItem(
                              icon: Icons.check_circle,
                              label: localizations.accuracy,
                              value: widget.stats.accuracyText,
                              color: Colors.green,
                            ),
                            _buildStatItem(
                              icon: Icons.local_fire_department,
                              label: localizations.best_streak,
                              value: '${widget.stats.bestStreak}',
                              color: Colors.orange,
                            ),
                            _buildStatItem(
                              icon: Icons.speed,
                              label: localizations.avg_speed,
                              value: widget.stats.averageSpeedText,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Divider(color: Colors.white24),
                        const SizedBox(height: 16),

                        // Detailed Stats
                        _buildDetailRow(
                          localizations.total_questions,
                          '${widget.stats.totalQuestions}',
                          Icons.quiz,
                        ),
                        const SizedBox(height: 8),
                        _buildDetailRow(
                          localizations.correct_answers,
                          '${widget.stats.correctAnswers}',
                          Icons.check,
                          valueColor: Colors.green,
                        ),
                        const SizedBox(height: 8),
                        _buildDetailRow(
                          localizations.wrong_answers,
                          '${widget.stats.wrongAnswers}',
                          Icons.close,
                          valueColor: Colors.red,
                        ),
                        const SizedBox(height: 8),
                        _buildDetailRow(
                          localizations.speed_bonuses,
                          '${widget.stats.speedBonuses}',
                          Icons.bolt,
                          valueColor: Colors.yellow,
                        ),
                        const SizedBox(height: 8),
                        _buildDetailRow(
                          localizations.total_points,
                          '${widget.stats.totalPoints}',
                          Icons.stars,
                          valueColor: Colors.amber,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Continue Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: widget.onContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 8,
                      ),
                      child: TextWidget(
                        title: localizations.continueButton,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            ),
          ),
        ),
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          size: 32,
          color: color,
        ),
        const SizedBox(height: 6),
        TextWidget(
          title: value,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        const SizedBox(height: 2),
        TextWidget(
          title: label,
          fontSize: 11,
          color: Colors.white70,
        ),
      ],
    );
  }

  Widget _buildDetailRow(
    String label,
    String value,
    IconData icon, {
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.white70,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextWidget(
            title: label,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        TextWidget(
          title: value,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: valueColor ?? Colors.white,
        ),
      ],
    );
  }
}
