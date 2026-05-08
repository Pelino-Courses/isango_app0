import 'package:flutter/material.dart';
import 'package:isango_app/core/constants/app_routes.dart';
import 'package:isango_app/core/theme/app_colors.dart';
import 'package:isango_app/core/theme/app_radii.dart';
import 'package:isango_app/core/theme/app_spacing.dart';
import 'package:isango_app/core/theme/app_text_styles.dart';
import 'package:isango_app/widgets/isango_bottom_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategory = 0;
  final _categories = ['Academic', 'Career', 'Sports', 'Cultural', 'Tech', 'Health'];

  final _events = [
    _Event(
      title: 'Student Union Leadership Summit 2024',
      organizer: 'Student Union',
      date: 'Oct 15, 10:00 AM',
      location: 'Student Center',
    ),
    _Event(
      title: 'Fall Semester Career & Internship Fair',
      organizer: 'Career Services',
      date: 'Oct 18, 9:00 AM',
      location: 'Athletic Complex',
    ),
    _Event(
      title: 'Campus Health & Wellness Week',
      organizer: 'Campus Health',
      date: 'Oct 20, 8:00 AM',
      location: 'North Quad Lawn',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mistBackground,
      appBar: AppBar(
        title: const Text(
          'Isango',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: AppColors.logisticsNavy,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: AppColors.logisticsNavy),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.logisticsNavy),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: const IsangoBottomNavigation(currentIndex: 0),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.page, AppSpacing.sm, AppSpacing.page, 0,
            ),
            child: _FeaturedCard(),
          ),
          const SizedBox(height: AppSpacing.md),
          // Category chips
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
              itemCount: _categories.length,
              separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.xs),
              itemBuilder: (context, i) {
                final selected = _selectedCategory == i;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
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
                      _categories[i],
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
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          // Upcoming events header
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.page),
            child: Text(
              'Upcoming Events',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColors.nearBlackInk,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          // Event list
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
            itemCount: _events.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, i) => _EventCard(
              event: _events[i],
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.eventDetail),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}

class _FeaturedCard extends StatefulWidget {
  @override
  State<_FeaturedCard> createState() => _FeaturedCardState();
}

class _FeaturedCardState extends State<_FeaturedCard> {
  bool _saved = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadii.card),
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xFF1E3A8A), Color(0xFF00236F)],
        ),
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.safetyOrange,
                  borderRadius: BorderRadius.circular(AppRadii.chip),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star_rounded, size: 14, color: Colors.white),
                    SizedBox(width: 4),
                    Text(
                      'Featured',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _saved = !_saved),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _saved ? Icons.bookmark : Icons.bookmark_outline,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const Text(
            'Annual Tech\nSymposium',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: const [
              Icon(Icons.access_time_outlined, size: 15, color: Colors.white70),
              SizedBox(width: 6),
              Text(
                '2:00 PM - 5:00 PM',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: const [
              Icon(Icons.location_on_outlined, size: 15, color: Colors.white70),
              SizedBox(width: 6),
              Text(
                'Main Hall, North Campus',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.safetyOrange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadii.button),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Register Now'),
                  SizedBox(width: AppSpacing.xs),
                  Icon(Icons.arrow_forward, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Event {
  const _Event({
    required this.title,
    required this.organizer,
    required this.date,
    required this.location,
  });

  final String title;
  final String organizer;
  final String date;
  final String location;
}

class _EventCard extends StatefulWidget {
  const _EventCard({required this.event, required this.onTap});
  final _Event event;
  final VoidCallback onTap;

  @override
  State<_EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<_EventCard> {
  bool _saved = false;

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
                Container(
                  height: 160,
                  color: AppColors.paleSignalBlue,
                  child: Center(
                    child: Icon(
                      Icons.event,
                      size: 56,
                      color: AppColors.logisticsNavy.withValues(alpha: 0.25),
                    ),
                  ),
                ),
                Positioned(
                  top: AppSpacing.sm,
                  right: AppSpacing.sm,
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
                  Text(
                    widget.event.organizer,
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        size: 14,
                        color: AppColors.mutedOperationalInk,
                      ),
                      const SizedBox(width: 6),
                      Text(widget.event.date, style: AppTextStyles.bodyMuted),
                      const SizedBox(width: AppSpacing.md),
                      const Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: AppColors.mutedOperationalInk,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          widget.event.location,
                          style: AppTextStyles.bodyMuted,
                          overflow: TextOverflow.ellipsis,
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
