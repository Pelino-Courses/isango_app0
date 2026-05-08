import 'package:flutter/material.dart';
import 'package:isango_app/core/constants/app_routes.dart';
import 'package:isango_app/core/theme/app_colors.dart';
import 'package:isango_app/core/theme/app_radii.dart';
import 'package:isango_app/core/theme/app_spacing.dart';
import 'package:isango_app/core/theme/app_text_styles.dart';
import 'package:isango_app/widgets/isango_bottom_navigation.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  int _selectedFilter = 0;
  final _filters = ['All Saved', 'RSVPs', 'Reminders'];

  final _events = [
    _SavedEvent(
      title: 'Student Tech Expo',
      organizer: 'Career Services',
      date: 'Oct 12, 10:00 AM',
      location: 'Main Hall',
      status: 'RSVP Confirmed',
      hasReminder: true,
      isLive: true,
    ),
    _SavedEvent(
      title: 'Zen Wellness Session',
      organizer: 'Campus Health',
      date: 'Oct 14, 2:00 PM',
      location: 'Student Lounge',
      status: 'RSVP Pending',
      hasReminder: false,
      isLive: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mistBackground,
      appBar: AppBar(
        title: const Text('Saved Events'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: const IsangoBottomNavigation(currentIndex: 1),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.page, AppSpacing.md, AppSpacing.page, 0,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(_filters.length, (i) {
                  final selected = _selectedFilter == i;
                  return Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.xs),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedFilter = i),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? AppColors.paleSignalBlue
                              : AppColors.cardWhite,
                          borderRadius: BorderRadius.circular(AppRadii.chip),
                          border: Border.all(
                            color: selected
                                ? AppColors.logisticsNavy
                                : AppColors.softBorder,
                          ),
                        ),
                        child: Text(
                          _filters[i],
                          style: TextStyle(
                            color: selected
                                ? AppColors.logisticsNavy
                                : AppColors.mutedOperationalInk,
                            fontWeight: selected
                                ? FontWeight.w600
                                : FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: _events.isEmpty
                ? _EmptyState(
                    onExplore: () =>
                        Navigator.pushReplacementNamed(context, AppRoutes.home),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.page,
                    ),
                    itemCount: _events.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.sm),
                    itemBuilder: (context, i) =>
                        _EventCard(event: _events[i]),
                  ),
          ),
        ],
      ),
    );
  }
}

class _SavedEvent {
  const _SavedEvent({
    required this.title,
    required this.organizer,
    required this.date,
    required this.location,
    required this.status,
    required this.hasReminder,
    required this.isLive,
  });

  final String title;
  final String organizer;
  final String date;
  final String location;
  final String status;
  final bool hasReminder;
  final bool isLive;
}

class _EventCard extends StatefulWidget {
  const _EventCard({required this.event});
  final _SavedEvent event;

  @override
  State<_EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<_EventCard> {
  bool _saved = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: AppColors.softBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 140,
                decoration: BoxDecoration(
                  color: AppColors.paleSignalBlue,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppRadii.card),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.event,
                    size: 48,
                    color: AppColors.logisticsNavy.withValues(alpha: 0.3),
                  ),
                ),
              ),
              if (widget.event.isLive)
                Positioned(
                  left: AppSpacing.sm,
                  bottom: AppSpacing.sm,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.safetyOrange,
                      borderRadius: BorderRadius.circular(AppRadii.chip),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.circle, size: 8, color: Colors.white),
                        SizedBox(width: 4),
                        Text(
                          'Live Now',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              Positioned(
                right: AppSpacing.sm,
                top: AppSpacing.sm,
                child: GestureDetector(
                  onTap: () => setState(() => _saved = !_saved),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.cardWhite,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Icon(
                      _saved ? Icons.bookmark : Icons.bookmark_outline,
                      size: 18,
                      color: AppColors.logisticsNavy,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.event.title, style: AppTextStyles.title),
                const SizedBox(height: AppSpacing.xxs),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined,
                        size: 14, color: AppColors.mutedOperationalInk),
                    const SizedBox(width: 4),
                    Text(widget.event.date, style: AppTextStyles.bodyMuted),
                    const SizedBox(width: AppSpacing.sm),
                    const Icon(Icons.location_on_outlined,
                        size: 14, color: AppColors.mutedOperationalInk),
                    const SizedBox(width: 4),
                    Text(widget.event.location, style: AppTextStyles.bodyMuted),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          widget.event.hasReminder
                              ? Icons.notifications_active_outlined
                              : Icons.notification_add_outlined,
                          size: 16,
                          color: AppColors.logisticsNavy,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.event.hasReminder
                              ? 'Reminder Set'
                              : 'Set Reminder',
                          style: const TextStyle(
                            color: AppColors.logisticsNavy,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: widget.event.status == 'RSVP Confirmed'
                            ? AppColors.paleSignalBlue
                            : AppColors.logisticsNavy,
                        borderRadius: BorderRadius.circular(AppRadii.chip),
                      ),
                      child: Text(
                        widget.event.status,
                        style: TextStyle(
                          color: widget.event.status == 'RSVP Confirmed'
                              ? AppColors.logisticsNavy
                              : Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onExplore});
  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.softBorder,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.bookmark_outline,
                size: 32,
                color: AppColors.mutedOperationalInk,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            const Text('No saved events', style: AppTextStyles.headline),
            const SizedBox(height: AppSpacing.xs),
            const Text(
              'Your saved list is empty. Explore upcoming events on campus to get started.',
              style: AppTextStyles.bodyMuted,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              onPressed: onExplore,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.logisticsNavy,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadii.button),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xl,
                  vertical: AppSpacing.sm,
                ),
              ),
              child: const Text('Explore Events'),
            ),
          ],
        ),
      ),
    );
  }
}
