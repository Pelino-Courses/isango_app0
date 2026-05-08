import 'package:flutter/material.dart';
import 'package:isango_app/core/theme/app_colors.dart';
import 'package:isango_app/core/theme/app_radii.dart';
import 'package:isango_app/core/theme/app_spacing.dart';
import 'package:isango_app/core/theme/app_text_styles.dart';

class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({super.key});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  bool _isSaved = false;
  bool _reminderSet = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mistBackground,
      appBar: AppBar(
        title: const Text('Event Details'),
        actions: [
          IconButton(
            icon: Icon(
              _isSaved ? Icons.bookmark : Icons.bookmark_outline,
              color: AppColors.logisticsNavy,
            ),
            onPressed: () => setState(() => _isSaved = !_isSaved),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero image
            SizedBox(
              height: 220,
              width: double.infinity,
              child: Image.network(
                'https://picsum.photos/seed/careerfair/800/400',
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) => progress == null
                    ? child
                    : Container(
                        color: AppColors.paleSignalBlue,
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                errorBuilder: (context, error, stack) => Container(
                  color: AppColors.paleSignalBlue,
                  child: Center(
                    child: Icon(
                      Icons.event,
                      size: 64,
                      color: AppColors.logisticsNavy.withValues(alpha: 0.25),
                    ),
                  ),
                ),
              ),
            ),
            // Scrollable content with padding
            Padding(
              padding: const EdgeInsets.all(AppSpacing.page),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header card
                  _SectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: AppSpacing.xs,
                          runSpacing: AppSpacing.xs,
                          children: const [
                            _Chip(
                              label: 'Main Campus',
                              icon: Icons.location_on_outlined,
                              background: AppColors.paleSignalBlue,
                              foreground: AppColors.logisticsNavy,
                            ),
                            _Chip(
                              label: 'Academic',
                              icon: Icons.school_outlined,
                              background: Color(0x338FA7FE),
                              foreground: Color(0xFF4059AA),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        const Text(
                          'Annual Career Fair 2024',
                          style: AppTextStyles.headline,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        const Text(
                          'Connecting students with industry leaders',
                          style: AppTextStyles.bodyMuted,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Row(
                          children: const [
                            Icon(Icons.calendar_today_outlined,
                                size: 16, color: AppColors.mutedOperationalInk),
                            SizedBox(width: AppSpacing.xs),
                            Text('Fri, Nov 15', style: AppTextStyles.bodyMuted),
                            SizedBox(width: AppSpacing.sm),
                            SizedBox(
                              width: 1,
                              height: 14,
                              child: ColoredBox(color: AppColors.softBorder),
                            ),
                            SizedBox(width: AppSpacing.sm),
                            Icon(Icons.access_time_outlined,
                                size: 16, color: AppColors.mutedOperationalInk),
                            SizedBox(width: AppSpacing.xs),
                            Text('10:00 AM – 4:00 PM', style: AppTextStyles.bodyMuted),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  // Organizer card
                  _SectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: AppColors.paleSignalBlue,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.groups_outlined,
                                color: AppColors.logisticsNavy,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            const Text('Student Career Center',
                                style: AppTextStyles.title),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        const _InfoRow(
                            icon: Icons.email_outlined,
                            text: 'career-center@university.edu'),
                        const SizedBox(height: AppSpacing.xs),
                        const _InfoRow(
                            icon: Icons.verified_outlined,
                            text: 'Host: University Services'),
                        const SizedBox(height: AppSpacing.xs),
                        GestureDetector(
                          onTap: () =>
                              setState(() => _reminderSet = !_reminderSet),
                          child: Row(
                            children: [
                              const Icon(Icons.notifications_outlined,
                                  size: 16, color: AppColors.logisticsNavy),
                              const SizedBox(width: AppSpacing.xs),
                              Text(
                                _reminderSet
                                    ? 'Reminder set: 30 mins before'
                                    : 'Remind me: 30 mins before',
                                style: const TextStyle(
                                  color: AppColors.logisticsNavy,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  // Location card
                  _SectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFFEDD5),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.apartment_outlined,
                                color: AppColors.safetyOrange,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            const Expanded(
                              child: Text('Grand Ballroom, Student Union',
                                  style: AppTextStyles.title),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        const _InfoRow(
                          icon: Icons.videocam_outlined,
                          text: 'Format: In-person / Hybrid options available',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  // About card
                  _SectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'About the Event',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.logisticsNavy,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        const Text(
                          'Join us for the biggest career event of the year! Over 100 companies will be on campus to meet with students from all faculties. Bring your CV and prepare for on-the-spot interviews.',
                          style: AppTextStyles.body,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Container(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          decoration: BoxDecoration(
                            color: AppColors.mistBackground,
                            borderRadius:
                                BorderRadius.circular(AppRadii.input),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(Icons.list_alt_outlined,
                                      color: AppColors.logisticsNavy,
                                      size: 20),
                                  SizedBox(width: AppSpacing.xs),
                                  Text('Agenda Summary',
                                      style: AppTextStyles.title),
                                ],
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              ...[
                                ('10:00 AM', 'Doors Open & Registration'),
                                ('10:30 AM', 'Keynote Address: Future of Work'),
                                ('11:00 AM', 'Networking Sessions Begin'),
                                ('4:00 PM', 'Event Concludes'),
                              ].map(
                                (item) => Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: AppSpacing.xs),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 80,
                                        child: Text(
                                          item.$1,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.logisticsNavy,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(item.$2,
                                            style: AppTextStyles.bodyMuted),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.page, AppSpacing.sm, AppSpacing.page, AppSpacing.md,
        ),
        decoration: const BoxDecoration(
          color: AppColors.cardWhite,
          border: Border(top: BorderSide(color: AppColors.softBorder)),
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => setState(() => _reminderSet = !_reminderSet),
                icon: Icon(
                  _reminderSet
                      ? Icons.notifications_active_outlined
                      : Icons.notifications_outlined,
                  size: 18,
                ),
                label: const Text('Set Reminder'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.logisticsNavy,
                  side: const BorderSide(color: AppColors.logisticsNavy),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadii.button),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Confirm RSVP'),
                    content: const Text('You\'re registering for Annual Career Fair 2024. We\'ll send a confirmation to your university email.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.safetyOrange,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('RSVP confirmed! Check your email.')),
                          );
                        },
                        child: const Text('Confirm RSVP'),
                      ),
                    ],
                  ),
                ),
                icon: const Icon(Icons.how_to_reg, size: 18),
                label: const Text('RSVP'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.safetyOrange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadii.button),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle:
                      AppTextStyles.body.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.child});
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

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.icon,
    required this.background,
    required this.foreground,
  });
  final String label;
  final IconData icon;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadii.chip),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: foreground),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: foreground,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.mutedOperationalInk),
        const SizedBox(width: AppSpacing.xs),
        Expanded(child: Text(text, style: AppTextStyles.bodyMuted)),
      ],
    );
  }
}
