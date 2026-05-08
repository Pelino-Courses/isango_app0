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

  final _allEvents = [
    _Event(
      title: 'Student Union Leadership Summit 2024',
      organizer: 'Student Union',
      date: 'Oct 15, 10:00 AM',
      location: 'Student Center',
      imageUrl: 'https://picsum.photos/seed/leadership/400/200',
      category: 'Academic',
    ),
    _Event(
      title: 'End-of-Semester Research Showcase',
      organizer: 'Faculty of Science',
      date: 'Oct 22, 2:00 PM',
      location: 'Library Hall',
      imageUrl: 'https://picsum.photos/seed/research/400/200',
      category: 'Academic',
    ),
    _Event(
      title: 'Fall Semester Career & Internship Fair',
      organizer: 'Career Services',
      date: 'Oct 18, 9:00 AM',
      location: 'Athletic Complex',
      imageUrl: 'https://picsum.photos/seed/career/400/200',
      category: 'Career',
    ),
    _Event(
      title: 'CV & Interview Workshop',
      organizer: 'Career Services',
      date: 'Oct 25, 11:00 AM',
      location: 'Room 204, Main Block',
      imageUrl: 'https://picsum.photos/seed/workshop/400/200',
      category: 'Career',
    ),
    _Event(
      title: 'Inter-Faculty Football Tournament',
      organizer: 'Sports Association',
      date: 'Oct 19, 8:00 AM',
      location: 'University Stadium',
      imageUrl: 'https://picsum.photos/seed/football/400/200',
      category: 'Sports',
    ),
    _Event(
      title: 'Annual Cross-Country Run',
      organizer: 'Athletics Club',
      date: 'Oct 26, 7:00 AM',
      location: 'Campus Track',
      imageUrl: 'https://picsum.photos/seed/athletics/400/200',
      category: 'Sports',
    ),
    _Event(
      title: 'African Cultural Night 2024',
      organizer: 'Cultural Committee',
      date: 'Oct 21, 6:00 PM',
      location: 'Main Auditorium',
      imageUrl: 'https://picsum.photos/seed/culture/400/200',
      category: 'Cultural',
    ),
    _Event(
      title: 'Poetry & Spoken Word Open Mic',
      organizer: 'Arts Club',
      date: 'Oct 28, 5:00 PM',
      location: 'Student Lounge',
      imageUrl: 'https://picsum.photos/seed/poetry/400/200',
      category: 'Cultural',
    ),
    _Event(
      title: 'Annual Tech Symposium',
      organizer: 'Tech Hub UR',
      date: 'Oct 17, 2:00 PM',
      location: 'Main Hall, North Campus',
      imageUrl: 'https://picsum.photos/seed/techsym/400/200',
      category: 'Tech',
    ),
    _Event(
      title: 'Hackathon: Build for Rwanda',
      organizer: 'Computer Science Club',
      date: 'Oct 24, 8:00 AM',
      location: 'ICT Lab, Block C',
      imageUrl: 'https://picsum.photos/seed/hackathon/400/200',
      category: 'Tech',
    ),
    _Event(
      title: 'Campus Health & Wellness Week',
      organizer: 'Campus Health',
      date: 'Oct 20, 8:00 AM',
      location: 'North Quad Lawn',
      imageUrl: 'https://picsum.photos/seed/wellness/400/200',
      category: 'Health',
    ),
    _Event(
      title: 'Mental Health Awareness Talk',
      organizer: 'Counseling Center',
      date: 'Oct 23, 10:00 AM',
      location: 'Conference Room B',
      imageUrl: 'https://picsum.photos/seed/mentalhealth/400/200',
      category: 'Health',
    ),
  ];

  List<_Event> get _filteredEvents {
    final cat = _categories[_selectedCategory];
    return _allEvents.where((e) => e.category == cat).toList();
  }

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
          onPressed: () => Navigator.pushNamed(context, AppRoutes.profile),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.logisticsNavy),
            onPressed: () => showSearch(
              context: context,
              delegate: _EventSearchDelegate(),
            ),
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
            child: _FeaturedCard(
              onRegister: () => Navigator.pushNamed(context, AppRoutes.eventDetail),
            ),
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
          Builder(
            builder: (context) {
              final events = _filteredEvents;
              if (events.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.page,
                    vertical: AppSpacing.xl,
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.event_busy_outlined,
                          size: 48,
                          color: AppColors.mutedOperationalInk.withValues(alpha: 0.5)),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'No ${_categories[_selectedCategory]} events right now',
                        style: AppTextStyles.bodyMuted,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
                itemCount: events.length,
                separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
                itemBuilder: (context, i) => _EventCard(
                  event: events[i],
                  onTap: () => Navigator.pushNamed(context, AppRoutes.eventDetail),
                ),
              );
            },
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}

class _FeaturedCard extends StatefulWidget {
  const _FeaturedCard({required this.onRegister});
  final VoidCallback onRegister;

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
              onPressed: widget.onRegister,
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
    required this.imageUrl,
    required this.category,
  });

  final String title;
  final String organizer;
  final String date;
  final String location;
  final String imageUrl;
  final String category;
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
                SizedBox(
                  height: 160,
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
                        child: Icon(Icons.event, size: 56, color: AppColors.logisticsNavy.withValues(alpha: 0.25)),
                      ),
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

class _EventSearchDelegate extends SearchDelegate<String> {
  final _suggestions = const [
    'Career Fair',
    'Tech Symposium',
    'Leadership Summit',
    'Wellness Week',
    'Cultural Night',
    'Sports Gala',
  ];

  @override
  String get searchFieldLabel => 'Search events...';

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, ''),
      );

  @override
  Widget buildResults(BuildContext context) {
    final results = _suggestions
        .where((s) => s.toLowerCase().contains(query.toLowerCase()))
        .toList();
    if (results.isEmpty) {
      return const Center(child: Text('No events found.'));
    }
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, i) => ListTile(
        leading: const Icon(Icons.event_outlined),
        title: Text(results[i]),
        onTap: () {
          close(context, results[i]);
          Navigator.pushNamed(context, AppRoutes.eventDetail);
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filtered = query.isEmpty
        ? _suggestions
        : _suggestions
            .where((s) => s.toLowerCase().contains(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, i) => ListTile(
        leading: const Icon(Icons.search, size: 18),
        title: Text(filtered[i]),
        onTap: () {
          query = filtered[i];
          showResults(context);
        },
      ),
    );
  }
}
