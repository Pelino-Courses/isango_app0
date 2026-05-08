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
  String _campus = 'Main Campus';
  String _reminderTiming = '30m before';
  final List<String> _interests = ['Tech', 'Design'];
  final _allInterests = const ['Tech', 'Design', 'Sports', 'Culture', 'Health', 'Academic', 'Career', 'Social'];

  void _pickCampus() {
    final campuses = ['Main Campus', 'North Campus', 'South Campus', 'Kigali Campus'];
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Preferred Campus'),
        children: campuses
            .map((c) => ListTile(
                  title: Text(c),
                  trailing: _campus == c ? const Icon(Icons.check, color: AppColors.logisticsNavy) : null,
                  onTap: () {
                    setState(() => _campus = c);
                    Navigator.pop(ctx);
                  },
                ))
            .toList(),
      ),
    );
  }

  void _pickReminderTiming() {
    final timings = ['15m before', '30m before', '1h before', '1 day before'];
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Reminder Timing'),
        children: timings
            .map((t) => ListTile(
                  title: Text(t),
                  trailing: _reminderTiming == t ? const Icon(Icons.check, color: AppColors.logisticsNavy) : null,
                  onTap: () {
                    setState(() => _reminderTiming = t);
                    Navigator.pop(ctx);
                  },
                ))
            .toList(),
      ),
    );
  }

  void _pickInterests() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Event Interests',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                const Text('Tap to add or remove interests',
                    style: TextStyle(fontSize: 13, color: Colors.grey)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _allInterests.map((interest) {
                    final selected = _interests.contains(interest);
                    return FilterChip(
                      label: Text(interest),
                      selected: selected,
                      onSelected: (on) {
                        setSheetState(() {
                          setState(() {
                            if (on) {
                              _interests.add(interest);
                            } else {
                              _interests.remove(interest);
                            }
                          });
                        });
                      },
                      selectedColor: AppColors.paleSignalBlue,
                      checkmarkColor: AppColors.logisticsNavy,
                      labelStyle: TextStyle(
                        color: selected
                            ? AppColors.logisticsNavy
                            : AppColors.mutedOperationalInk,
                        fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(ctx),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.logisticsNavy,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadii.button),
                      ),
                    ),
                    child: const Text('Done'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
        actions: [
          IconButton(
            icon: const CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.paleSignalBlue,
              child: Icon(Icons.person, size: 18, color: AppColors.logisticsNavy),
            ),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.profile),
          ),
        ],
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
                subtitle: _campus,
                onTap: _pickCampus,
              ),
              const Divider(height: 1, color: AppColors.softBorder),
              _NavTile(
                title: 'Event Interests',
                subtitle: '',
                trailing: Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: [
                    ..._interests.map((i) => GestureDetector(
                          onTap: () => setState(() => _interests.remove(i)),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.paleSignalBlue,
                              borderRadius:
                                  BorderRadius.circular(AppRadii.chip),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(i,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.logisticsNavy,
                                        fontWeight: FontWeight.w500)),
                                const SizedBox(width: 4),
                                const Icon(Icons.close,
                                    size: 12,
                                    color: AppColors.logisticsNavy),
                              ],
                            ),
                          ),
                        )),
                    GestureDetector(
                      onTap: _pickInterests,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.cardWhite,
                          borderRadius: BorderRadius.circular(AppRadii.chip),
                          border: Border.all(color: AppColors.softBorder),
                        ),
                        child: const Text('+ Add',
                            style: TextStyle(
                                fontSize: 12,
                                color: AppColors.mutedOperationalInk,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ],
                ),
                onTap: _pickInterests,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _SectionHeader('Reminders'),
          _SettingsCard(
            children: [
              _NavTile(
                title: 'Reminder Timing',
                subtitle: _reminderTiming,
                onTap: _pickReminderTiming,
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
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opening support page...')),
                ),
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

