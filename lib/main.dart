import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(const ChurchApp());
}

class ChurchApp extends StatelessWidget {
  const ChurchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Church App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(131, 179, 163, 1), // Main sage green
          primary: const Color.fromRGBO(131, 179, 163, 1),
          secondary:
              const Color.fromRGBO(131, 179, 163, 0.8), // Slightly lighter
          tertiary: const Color.fromRGBO(131, 179, 163, 0.6), // Even lighter
          background:
              const Color.fromRGBO(131, 179, 163, 0.05), // Very light tint
          surface: Colors.white,
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.poppinsTextTheme().copyWith(
          displayLarge: GoogleFonts.playfairDisplay(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: const Color.fromRGBO(131, 179, 163, 1),
          ),
          displayMedium: GoogleFonts.playfairDisplay(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: const Color.fromRGBO(131, 179, 163, 1),
          ),
          titleLarge: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: const Color.fromRGBO(131, 179, 163, 1),
          ),
          titleMedium: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color.fromRGBO(131, 179, 163, 1),
          ),
          bodyLarge: GoogleFonts.poppins(
            fontSize: 16,
            color: const Color(0xFF2C3E50),
          ),
          bodyMedium: GoogleFonts.poppins(
            fontSize: 14,
            color: const Color(0xFF2C3E50),
          ),
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(131, 179, 163, 1),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color.fromRGBO(131, 179, 163, 1),
            side: const BorderSide(color: Color.fromRGBO(131, 179, 163, 1)),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: const Color.fromRGBO(131, 179, 163, 0.1),
          labelTextStyle: MaterialStateProperty.all(
            GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: const [
            HomeScreen(),
            SermonsScreen(),
            EventsScreen(),
            PrayerScreen(),
            MoreScreen(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.book_outlined),
            selectedIcon: Icon(Icons.book),
            label: 'Sermons',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.calendar_today),
            label: 'Events',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            selectedIcon: Icon(Icons.favorite),
            label: 'Prayer',
          ),
          NavigationDestination(
            icon: Icon(Icons.more_horiz_outlined),
            selectedIcon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary.withOpacity(0.8),
                  ],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/FBC-color-horizontal.png',
                      height: 80, // Adjust as needed
                    ).animate().fadeIn().slideY(begin: 0.3, end: 0),
                    const SizedBox(height: 8),
                    Text(
                      'A Church on the move',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                    ).animate().fadeIn().slideY(begin: 0.3, end: 0),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
              icon:
                  const Icon(Icons.notifications_outlined, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Service Times Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.access_time,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Service Times',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildServiceTime(
                          context,
                          'Sunday Service',
                          '10:30 AM',
                          'Main Sanctuary',
                        ),
                        const Divider(height: 24),
                        _buildServiceTime(
                          context,
                          'Wednesday Service',
                          '5:30 PM',
                          'Main Sanctuary',
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.calendar_today),
                            label: const Text('Add to Calendar'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Latest Sermon
                Text(
                  'Latest Sermon',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Card(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.8),
                                  Theme.of(context).colorScheme.primary,
                                ],
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.play_circle_outline,
                                size: 64,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Walking in Faith',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Pastor John Smith',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.7),
                                  ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                OutlinedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.play_arrow),
                                  label: const Text('Watch'),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.download_outlined),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Announcements
                Text(
                  'Announcements',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.campaign_outlined,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    title: Text(
                      'Youth Group Meeting',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          'Friday, 7:00 PM',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.7),
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Join us for an evening of fellowship and fun!',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceTime(
    BuildContext context,
    String title,
    String time,
    String location,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Text(
                  location,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.7),
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

class SermonsScreen extends StatelessWidget {
  const SermonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          title: Text(
            'Sermons',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {},
            ),
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildSermonCard(context, index),
              childCount: 10, // Show 10 sermons for demo
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSermonCard(BuildContext context, int index) {
    final sermons = [
      {
        'title': 'Walking in Faith',
        'pastor': 'Pastor John Smith',
        'date': 'March 10, 2024',
        'duration': '45:30',
      },
      {
        'title': 'The Power of Prayer',
        'pastor': 'Pastor Sarah Johnson',
        'date': 'March 3, 2024',
        'duration': '42:15',
      },
      {
        'title': 'Living with Purpose',
        'pastor': 'Pastor John Smith',
        'date': 'February 25, 2024',
        'duration': '48:20',
      },
      {
        'title': 'God\'s Grace',
        'pastor': 'Pastor Sarah Johnson',
        'date': 'February 18, 2024',
        'duration': '44:10',
      },
      {
        'title': 'Faith in Action',
        'pastor': 'Pastor John Smith',
        'date': 'February 11, 2024',
        'duration': '46:45',
      },
    ];

    final sermon = sermons[index % sermons.length];

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // TODO: Navigate to sermon detail
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).colorScheme.primary.withOpacity(0.8),
                      Theme.of(context).colorScheme.primary,
                    ],
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(
                      Icons.play_circle_outline,
                      size: 48,
                      color: Colors.white,
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          sermon['duration']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sermon['title']!,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    sermon['pastor']!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.7),
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    sermon['date']!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.download_outlined),
                        onPressed: () {},
                        iconSize: 20,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      IconButton(
                        icon: const Icon(Icons.share_outlined),
                        onPressed: () {},
                        iconSize: 20,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
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

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final Map<DateTime, List<Event>> _events = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _loadEvents();
  }

  void _loadEvents() {
    // Sample events data
    final now = DateTime.now();
    final events = [
      Event(
        title: 'Sunday Service',
        description: 'Join us for worship and fellowship',
        startTime: '10:30 AM',
        endTime: '12:00 PM',
        location: 'Main Sanctuary',
        date: now,
      ),
      Event(
        title: 'Youth Group Meeting',
        description: 'Weekly youth gathering with games and Bible study',
        startTime: '6:00 PM',
        endTime: '8:00 PM',
        location: 'Youth Center',
        date: now.add(const Duration(days: 2)),
      ),
      Event(
        title: 'Prayer Meeting',
        description: 'Community prayer gathering',
        startTime: '7:00 PM',
        endTime: '8:30 PM',
        location: 'Prayer Room',
        date: now.add(const Duration(days: 3)),
      ),
      Event(
        title: 'Bible Study',
        description: 'In-depth study of the Book of John',
        startTime: '7:00 PM',
        endTime: '8:30 PM',
        location: 'Conference Room',
        date: now.add(const Duration(days: 5)),
      ),
      // Fake events for days 26 to 30 of the current month
      Event(
        title: 'Special Choir Practice',
        description: 'Preparation for Sunday performance.',
        startTime: '5:00 PM',
        endTime: '6:30 PM',
        location: 'Choir Room',
        date: DateTime(now.year, now.month, 26),
      ),
      Event(
        title: 'Community Outreach',
        description: 'Join us to serve the local community.',
        startTime: '9:00 AM',
        endTime: '12:00 PM',
        location: 'Community Center',
        date: DateTime(now.year, now.month, 27),
      ),
      Event(
        title: 'Men\'s Breakfast',
        description: 'Fellowship and breakfast for men of all ages.',
        startTime: '8:00 AM',
        endTime: '9:30 AM',
        location: 'Fellowship Hall',
        date: DateTime(now.year, now.month, 28),
      ),
      Event(
        title: 'Women\'s Bible Study',
        description: 'Weekly study and discussion.',
        startTime: '6:30 PM',
        endTime: '8:00 PM',
        location: 'Room 204',
        date: DateTime(now.year, now.month, 29),
      ),
      Event(
        title: 'Family Movie Night',
        description: 'Fun for all ages! Popcorn provided.',
        startTime: '7:00 PM',
        endTime: '9:00 PM',
        location: 'Main Sanctuary',
        date: DateTime(now.year, now.month, 30),
      ),
    ];

    for (var event in events) {
      final date = DateTime(
        event.date.year,
        event.date.month,
        event.date.day,
      );
      if (_events[date] == null) _events[date] = [];
      _events[date]!.add(event);
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    final normalized = DateTime(day.year, day.month, day.day);
    return _events[normalized] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          title: Text(
            'Events',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                // TODO: Add new event
              },
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Card(
            margin: const EdgeInsets.all(16),
            child: TableCalendar(
              firstDay: DateTime.now().subtract(const Duration(days: 365 * 5)),
              lastDay: DateTime.now().add(const Duration(days: 365 * 5)),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                markerDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  shape: BoxShape.circle,
                ),
              ),
              eventLoader: _getEventsForDay,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final events = _getEventsForDay(_selectedDay!);
                if (events.isEmpty) {
                  if (index == 0) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('No events for this day'),
                      ),
                    );
                  } else {
                    return null;
                  }
                }
                if (index >= events.length) return null;
                return _buildEventCard(context, events[index]);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEventCard(BuildContext context, Event event) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to event details
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.event,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${event.startTime} - ${event.endTime}',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.7),
                                  ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_alert_outlined),
                    onPressed: () {
                      // TODO: Add to calendar
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                event.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    event.location,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Event {
  final String title;
  final String description;
  final String startTime;
  final String endTime;
  final String location;
  final DateTime date;

  Event({
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.date,
  });
}

class PrayerScreen extends StatefulWidget {
  const PrayerScreen({super.key});

  @override
  State<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _requestController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final List<Map<String, String>> _prayerRequests = [
    {
      'name': 'Anonymous',
      'request': 'Please pray for my family during this difficult time.'
    },
    {'name': 'Sarah', 'request': 'Pray for my upcoming job interview.'},
    {'name': 'John', 'request': 'Healing for a friend in the hospital.'},
  ];

  void _submitRequest() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _prayerRequests.insert(0, {
          'name':
              _nameController.text.isEmpty ? 'Anonymous' : _nameController.text,
          'request': _requestController.text,
        });
        _nameController.clear();
        _requestController.clear();
        _contactController.clear();
      });
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Prayer request submitted!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          title: Text(
            'Prayer Requests',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Submit a Prayer Request',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Let us pray for you. Fill out the form below and our prayer team will lift your request up.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              labelText: 'Your Name (optional)',
                              prefixIcon: Icon(Icons.person_outline),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _requestController,
                            decoration: const InputDecoration(
                              labelText: 'Prayer Request',
                              prefixIcon: Icon(Icons.favorite_border),
                            ),
                            maxLines: 3,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your prayer request.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _contactController,
                            decoration: const InputDecoration(
                              labelText: 'Contact Info (optional)',
                              prefixIcon: Icon(Icons.email_outlined),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: _submitRequest,
                              icon: const Icon(Icons.send),
                              label: const Text('Submit'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Recent Prayer Requests',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index >= _prayerRequests.length) return null;
                final request = _prayerRequests[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.15),
                      child:
                          const Icon(Icons.favorite, color: Colors.redAccent),
                    ),
                    title: Text(request['name'] ?? 'Anonymous',
                        style: Theme.of(context).textTheme.titleSmall),
                    subtitle: Text(request['request'] ?? ''),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _requestController.dispose();
    _contactController.dispose();
    super.dispose();
  }
}

// Profile Screen
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 48)),
            const SizedBox(height: 16),
            Text('John Doe', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('john.doe@email.com'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

// Church Info Screen
class ChurchInfoScreen extends StatelessWidget {
  const ChurchInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Church Info')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 80, // Adjust as needed
            ).animate().fadeIn().slideY(begin: 0.3, end: 0),
            const SizedBox(height: 8),
            Text('3091 Advent Court, Lake Charles, LA 70607'),
            const SizedBox(height: 8),
            Text('Sunday Service: 10:30 AM'),
            Text('Wednesday Service: 5:30 PM'),
            const SizedBox(height: 16),
            Text('Contact: (337) 433-1443'),
            Text('Email: FBCLakeCharles@yahoo.com'),
            const SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.map),
                  onPressed: () {
                    // TODO: Open map
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.facebook),
                  onPressed: () {
                    // TODO: Open Facebook
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.language),
                  onPressed: () {
                    // TODO: Open website
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Online Giving Screen
class OnlineGivingScreen extends StatelessWidget {
  const OnlineGivingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Online Giving')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.volunteer_activism,
                size: 64, color: Color(0xFF4A7C59)),
            const SizedBox(height: 16),
            const Text('Support our church online!'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // TODO: Launch giving page
              },
              child: const Text('Give Now'),
            ),
          ],
        ),
      ),
    );
  }
}

// Ministries Screen
class MinistriesScreen extends StatelessWidget {
  const MinistriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ministries = [
      {
        'icon': Icons.child_care,
        'name': 'Children',
        'desc': 'Fun and faith for kids.'
      },
      {
        'icon': Icons.emoji_people,
        'name': 'Youth',
        'desc': 'Teens growing in Christ.'
      },
      {
        'icon': Icons.music_note,
        'name': 'Music',
        'desc': 'Choir, band, and worship.'
      },
      {
        'icon': Icons.volunteer_activism,
        'name': 'Outreach',
        'desc': 'Serving our community.'
      },
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Ministries')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: ministries.length,
        itemBuilder: (context, i) => Card(
          child: ListTile(
            leading: Icon(ministries[i]['icon'] as IconData,
                color: Theme.of(context).colorScheme.primary),
            title: Text(ministries[i]['name'] as String),
            subtitle: Text(ministries[i]['desc'] as String),
          ),
        ),
      ),
    );
  }
}

// Settings Screen
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Dark Theme'),
            value: false,
            onChanged: (v) {
              // TODO: Implement theme switching
            },
          ),
          SwitchListTile(
            title: const Text('Notifications'),
            value: true,
            onChanged: (v) {
              // TODO: Implement notifications
            },
          ),
        ],
      ),
    );
  }
}

// Contact Us Screen
class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController();
    final _emailController = TextEditingController();
    final _messageController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('Contact Us')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _messageController,
                decoration: const InputDecoration(labelText: 'Message'),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Send message
                  },
                  child: const Text('Send'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Update MoreScreen navigation
class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('More', style: theme.textTheme.titleLarge),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.primary.withOpacity(0.15),
                child: const Icon(Icons.person, color: Color(0xFF4A7C59)),
              ),
              title: const Text('Profile'),
              subtitle: const Text('View and edit your profile'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.primary.withOpacity(0.15),
                child: const Icon(Icons.info_outline, color: Color(0xFF4A7C59)),
              ),
              title: const Text('Church Info'),
              subtitle: const Text('About, address, and contact'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ChurchInfoScreen()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.primary.withOpacity(0.15),
                child: const Icon(Icons.volunteer_activism,
                    color: Color(0xFF4A7C59)),
              ),
              title: const Text('Online Giving'),
              subtitle: const Text('Support the church online'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const OnlineGivingScreen()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.primary.withOpacity(0.15),
                child: const Icon(Icons.groups, color: Color(0xFF4A7C59)),
              ),
              title: const Text('Ministries'),
              subtitle: const Text('Explore our ministries'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const MinistriesScreen()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.primary.withOpacity(0.15),
                child: const Icon(Icons.settings, color: Color(0xFF4A7C59)),
              ),
              title: const Text('Settings'),
              subtitle: const Text('App preferences'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.primary.withOpacity(0.15),
                child: const Icon(Icons.mail_outline, color: Color(0xFF4A7C59)),
              ),
              title: const Text('Contact Us'),
              subtitle: const Text('Get in touch with us'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ContactUsScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
