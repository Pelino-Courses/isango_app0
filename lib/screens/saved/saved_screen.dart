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
      date: 'Oct 12',
      time: '10:00 AM – 1:00 PM',
      location: 'Main Hall',
      status: 'RSVP Confirmed',
      hasReminder: true,
      isLive: true,
      imageUrl: 'https://picsum.photos/seed/techexpo/400/200',
    ),
    _SavedEvent(
      title: 'Zen Wellness Session',
      organizer: 'Campus Health',
      date: 'Oct 14',
      time: '2:00 PM – 4:00 PM',
      location: 'Student Lounge',
      status: 'RSVP Pending',
      hasReminder: false,
      isLive: false,
      imageUrl: 'https://picsum.photos/seed/zenwell/400/200',
    ),
    _SavedEvent(
      title: 'African Cultural Night 2024',
      organizer: 'Cultural Committee',
      date: 'Oct 21',
      time: '6:00 PM – 10:00 PM',
      location: 'Main Auditorium',
      status: 'Saved',
      hasReminder: true,
      isLive: false,
      imageUrl: 'https://picsum.photos/seed/culture/400/200',
    ),
    _SavedEvent(
      title: 'Hackathon: Build for Rwanda',
      organizer: 'CS Club',
      date: 'Oct 24',
      time: '8:00 AM – 8:00 PM',
      location: 'ICT Lab, Block C',
      status: 'RSVP Confirmed',
      hasReminder: true,
      isLive: false,
      imageUrl: 'https://picsum.photos/seed/hackathon/400/200',
    ),
    _SavedEvent(
      title: 'Mental Health Awareness Talk',
      organizer: 'Counseling Center',
      date: 'Oct 23',
      time: '10:00 AM – 12:00 PM',
      location: 'Conference Room B',
      status: 'Saved',
      hasReminder: false,
      isLive: false,
      imageUrl: 'https://picsum.photos/seed/mentalhealth/400/200',
    ),
  ];

  List<_SavedEvent> get _filteredEvents {
    switch (_selectedFilter) {
      case 1: // RSVPs
        return _events.where((e) => e.status.contains('RSVP')).toList();
      case 2: // Reminders
        return _events.where((e) => e.hasReminder).toList();
      default: // All Saved
        return _events;
    }
  }

  String get _emptyMessage {
    switch (_selectedFilter) {
      case 1:
        return 'No RSVPs yet. Register for events to see them here.';
      case 2:
        return 'No reminders set. Open an event and tap Set Reminder.';
      default:
        return 'Your saved list is empty. Explore upcoming events to get started.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mistBackground,
      appBar: AppBar(
        title: const Text('Saved Events'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Navigator.pushNamed(context, AppRoutes.profile),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (ctx) => SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.sort_outlined),
                      title: const Text('Sort by Date'),
                      onTap: () {
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Sorted by date')),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.filter_list_outlined),
                      title: const Text('Filter by Campus'),
                      onTap: () {
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Filter applied')),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.delete_outline, color: Colors.red),
                      title: const Text('Clear All Saved', style: TextStyle(color: Colors.red)),
                      onTap: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
              ),
            ),
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
            child: _filteredEvents.isEmpty
                ? _EmptyState(
                    message: _emptyMessage,
                    onExplore: () =>
                        Navigator.pushReplacementNamed(context, AppRoutes.home),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.page,
                    ),
                    itemCount: _filteredEvents.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.sm),
                    itemBuilder: (context, i) => _EventCard(
                      event: _filteredEvents[i],
                      onTap: () => Navigator.pushNamed(context, AppRoutes.eventDetail),
                    ),
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
    required this.time,
    required this.location,
    required this.status,
    required this.hasReminder,
    required this.isLive,
    required this.imageUrl,
  });

  final String title;
  final String organizer;
  final String date;
  final String time;
  final String location;
  final String status;
  final bool hasReminder;
  final bool isLive;
  final String imageUrl;
}

class _EventCard extends StatefulWidget {
  const _EventCard({required this.event, required this.onTap});
  final _SavedEvent event;
  final VoidCallback onTap;

  @override
  State<_EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<_EventCard> {
  bool _saved = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: AppColors.softBorder),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 140,
                width: double.infinity,
                child: Image.network(
                  widget.event.imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) => progress == null
                      ? child
                      : Container(
                          color: AppColors.paleSignalBlue,
                          child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                        ),
                  errorBuilder: (context, error, stack) => Container(
                    color: AppColors.paleSignalBlue,
                    child: Center(
                      child: Icon(Icons.event, size: 48, color: AppColors.logisticsNavy.withValues(alpha: 0.3)),
                    ),
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
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.access_time_outlined,
                        size: 14, color: AppColors.mutedOperationalInk),
                    const SizedBox(width: 4),
                    Text(widget.event.time, style: AppTextStyles.bodyMuted),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
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
    ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onExplore, required this.message});
  final VoidCallback onExplore;
  final String message;

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
            const Text('Nothing here yet', style: AppTextStyles.headline),
            const SizedBox(height: AppSpacing.xs),
            Text(
              message,
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
