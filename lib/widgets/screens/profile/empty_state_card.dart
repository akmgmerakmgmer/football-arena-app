import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class EmptyStateCard extends StatelessWidget {
  final String message;
  final String? actionLabel;
  final VoidCallback? onActionTap;
  final IconData icon;
  
  const EmptyStateCard({
    super.key,
    required this.message,
    this.actionLabel,
    this.onActionTap,
    this.icon = Icons.inbox_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.withOpacity(0.1),
              border: Border.all(
                color: Colors.grey.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Icon(
              icon,
              size: 48,
              color: Colors.grey.shade400,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Message
          TextWidget(
            title: message,
            fontSize: 15,
            color: Colors.grey.shade300,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w500,
          ),
          
          // Action Button
          if (actionLabel != null && onActionTap != null) ...[
            const SizedBox(height: 20),
            GestureDetector(
              onTap: onActionTap,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withOpacity(0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withOpacity(0.4),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.shopping_bag,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    TextWidget(
                      title: actionLabel!,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
