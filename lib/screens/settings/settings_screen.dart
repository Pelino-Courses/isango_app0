import 'package:flutter/material.dart';
import 'package:isango_app/core/constants/app_routes.dart';
import 'package:isango_app/core/theme/app_colors.dart';
import 'package:isango_app/core/theme/app_radii.dart';
import 'package:isango_app/core/theme/app_spacing.dart';
import 'package:isango_app/core/theme/app_text_styles.dart';
import 'package:isango_app/widgets/isango_bottom_navigation.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _rsvpAutoCalendar = true;
  bool _compactMode = false;
  bool _dataSaving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mistBackground,
      appBar: AppBar(
        title: const Text('Settings'),
        leading: const Padding(
          padding: EdgeInsets.only(left: AppSpacing.md),
          child: Icon(Icons.settings_outlined, color: AppColors.logisticsNavy),
        ),
      ),
      bottomNavigationBar: const IsangoBottomNavigation(currentIndex: 3),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.page),
        children: [
          _SectionHeader('Preferences'),
          _SettingsCard(
            children: [
              _NavTile(
                title: 'Preferred Campus',
                subtitle: 'Main Campus',
                onTap: () {},
              ),
              const Divider(height: 1, color: AppColors.softBorder),
              _NavTile(
                title: 'Event Interests',
                subtitle: '',
                trailing: Wrap(
                  spacing: 4,
                  children: const [
                    _InterestChip('Tech'),
                    _InterestChip('Design'),
                    _AddChip(),
                  ],
                ),
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _SectionHeader('Reminders'),
          _SettingsCard(
            children: [
              _NavTile(
                title: 'Reminder Timing',
                subtitle: '30m before',
                onTap: () {},
              ),
              const Divider(height: 1, color: AppColors.softBorder),
              _ToggleTile(
                title: 'RSVP Defaults',
                subtitle: 'Auto-add to calendar',
                value: _rsvpAutoCalendar,
                onChanged: (v) => setState(() => _rsvpAutoCalendar = v),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _SectionHeader('App Experience'),
          _SettingsCard(
            children: [
              _ToggleTile(
                title: 'Compact Mode',
                subtitle: 'Hide event images in lists',
                value: _compactMode,
                onChanged: (v) => setState(() => _compactMode = v),
              ),
              const Divider(height: 1, color: AppColors.softBorder),
              _ToggleTile(
                title: 'Data-saving Mode',
                subtitle: 'Reduce image quality',
                value: _dataSaving,
                onChanged: (v) => setState(() => _dataSaving = v),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _SectionHeader('About'),
          _SettingsCard(
            children: [
              _NavTile(
                title: 'Version',
                subtitle: 'v1.2.0',
                showChevron: false,
                onTap: null,
              ),
              const Divider(height: 1, color: AppColors.softBorder),
              _NavTile(
                title: 'Support & Feedback',
                subtitle: '',
                trailingIcon: Icons.open_in_new_outlined,
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Center(
            child: TextButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, AppRoutes.login),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.criticalRed,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xl,
                  vertical: AppSpacing.sm,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadii.button),
                  side: const BorderSide(color: AppColors.criticalRed),
                ),
              ),
              child: const Text(
                'Log Out',
                style: TextStyle(
                  color: AppColors.criticalRed,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.logisticsNavy,
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: AppColors.softBorder),
      ),
      child: Column(children: children),
    );
  }
}

class _NavTile extends StatelessWidget {
  const _NavTile({
    required this.title,
    required this.subtitle,
    this.trailing,
    this.trailingIcon,
    this.showChevron = true,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final Widget? trailing;
  final IconData? trailingIcon;
  final bool showChevron;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: AppTextStyles.body),
      subtitle: subtitle.isNotEmpty
          ? Text(subtitle, style: AppTextStyles.bodyMuted)
          : trailing,
      trailing: trailingIcon != null
          ? Icon(trailingIcon, color: AppColors.logisticsNavy)
          : showChevron
              ? const Icon(Icons.chevron_right,
                  color: AppColors.mutedOperationalInk)
              : null,
      onTap: onTap,
    );
  }
}

class _ToggleTile extends StatelessWidget {
  const _ToggleTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(title, style: AppTextStyles.body),
      subtitle: Text(subtitle, style: AppTextStyles.bodyMuted),
      value: value,
      activeThumbColor: AppColors.logisticsNavy,
      onChanged: onChanged,
    );
  }
}

class _InterestChip extends StatelessWidget {
  const _InterestChip(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.paleSignalBlue,
        borderRadius: BorderRadius.circular(AppRadii.chip),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          color: AppColors.logisticsNavy,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _AddChip extends StatelessWidget {
  const _AddChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(AppRadii.chip),
        border: Border.all(color: AppColors.softBorder),
      ),
      child: const Text(
        '+ Add',
        style: TextStyle(
          fontSize: 12,
          color: AppColors.mutedOperationalInk,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
