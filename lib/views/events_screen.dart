import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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
