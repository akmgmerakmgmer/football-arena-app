import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/containers/page_container_with_footer.dart';
import 'package:in_zone_app/widgets/containers/pages_asset_background.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/screens/home/events.dart';
import 'package:in_zone_app/widgets/screens/home/question_mods.dart';
import 'package:provider/provider.dart';

class PlayAlone extends StatelessWidget {
  const PlayAlone({super.key});

  Widget _buildSectionTitle({
    required BuildContext context,
    required String title,
    required String titleAr,
    required String locale,
    required IconData icon,
    required Color accentColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accentColor.withOpacity(0.25),
            accentColor.withOpacity(0.15),
            Colors.white.withOpacity(0.05),
          ],
        ),
        border: Border.all(
          color: accentColor.withOpacity(0.5),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.2),
            blurRadius: 12,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.25),
                  Colors.white.withOpacity(0.15),
                ],
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: Icon(
              icon,
              color: accentColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          TextWidget(
            title: locale == 'en' ? title : titleAr,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleProvider>(context).locale;
    final events = Provider.of<LocaleProvider>(context).events;

    return PageContainerWithFooter(
      background: Theme.of(context).splashColor,
      body: PagesAssetBackground(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Events Section
              if (events.isNotEmpty) ...[
                _buildSectionTitle(
                  context: context,
                  title: 'EVENTS & TOURNAMENTS',
                  titleAr: 'الفعاليات والبطولات',
                  locale: locale,
                  icon: Icons.emoji_events,
                  accentColor: const Color(0xFFFFD700), // Gold - Trophy/Champions
                ),
                const Events(),
              ],

              // Game Modes Section
              _buildSectionTitle(
                context: context,
                title: 'GAME MODES',
                titleAr: 'أنماط اللعب',
                locale: locale,
                icon: Icons.sports_soccer,
                accentColor: const Color(0xFF4CAF50), // Green - Football Field
              ),
              const QuestionMods(),
            ],
          ),
        ),
      ),
    );
  }
}
