import 'package:flutter/material.dart';
import 'package:isango_app/core/constants/app_routes.dart';
import 'package:isango_app/core/theme/app_colors.dart';
import 'package:isango_app/core/theme/app_radii.dart';
import 'package:isango_app/core/theme/app_spacing.dart';
import 'package:isango_app/core/theme/app_text_styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mistBackground,
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, AppRoutes.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.page),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile card
            _Card(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.paleSignalBlue,
                        borderRadius: BorderRadius.circular(AppRadii.chip),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.verified_outlined,
                              size: 14, color: AppColors.logisticsNavy),
                          SizedBox(width: 4),
                          Text(
                            'Verified Student',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.logisticsNavy,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.paleSignalBlue,
                    child: const Icon(
                      Icons.person,
                      size: 40,
                      color: AppColors.logisticsNavy,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  const Text('Alex Rivera', style: AppTextStyles.headline),
                  const SizedBox(height: AppSpacing.xxs),
                  const Text(
                    'alex.rivera@university.edu',
                    style: AppTextStyles.bodyMuted,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            // Role card
            _Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Role',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.logisticsNavy,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.paleSignalBlue,
                          borderRadius: BorderRadius.circular(AppSpacing.sm),
                        ),
                        child: const Icon(
                          Icons.badge_outlined,
                          color: AppColors.logisticsNavy,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Student Ambassador',
                              style: AppTextStyles.title,
                            ),
                            SizedBox(height: AppSpacing.xxs),
                            Text(
                              'You have access to featured event submissions and community leaderboards. Your role determines your publishing permissions within the campus ecosystem.',
                              style: AppTextStyles.bodyMuted,
                            ),
                            SizedBox(height: AppSpacing.xs),
                            Text(
                              'IDENTITY VERIFIED • ROLE-BASED ACCESS ACTIVE',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppColors.mutedOperationalInk,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            // Account Settings button
            OutlinedButton.icon(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.settings),
              icon: const Icon(Icons.manage_accounts_outlined),
              label: const Text('Account Settings'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.logisticsNavy,
                side: const BorderSide(color: AppColors.logisticsNavy),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadii.button),
                ),
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                textStyle: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            // Sign Out button
            OutlinedButton.icon(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, AppRoutes.login),
              icon: const Icon(Icons.logout_outlined,
                  color: AppColors.criticalRed),
              label: const Text('Sign Out'),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF93000A),
                backgroundColor: const Color(0xFFFFDAD6),
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadii.button),
                ),
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                textStyle: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: AppColors.softBorder),
      ),
      child: child,
    );
  }
}
