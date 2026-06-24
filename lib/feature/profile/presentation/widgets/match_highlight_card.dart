import 'package:flutter/material.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';

class MatchHighlightCard extends StatelessWidget {
  final String matchLabel;
  final String title;
  final String date;
  final String duration;
  final String imageUrl;

  const MatchHighlightCard({
    super.key,
    required this.matchLabel,
    required this.title,
    required this.date,
    required this.duration,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Container(
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(imageUrl, fit: BoxFit.cover),
              ),
              Positioned(
                left: 16,
                top: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: theme.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    matchLabel,
                    style: theme.medium14.copyWith(
                      color: theme.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 16,
                bottom: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.play_arrow,
                        color: theme.secondary,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        duration,
                        style: theme.medium14.copyWith(
                          color: theme.secondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.semiBold16.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  date,
                  style: theme.regular14.copyWith(
                    color: theme.subTitle,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
