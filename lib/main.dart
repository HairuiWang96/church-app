import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:table_calendar/table_calendar.dart';
import 'views/home_screen.dart';
import 'views/sermons_screen.dart';
import 'views/events_screen.dart';
import 'views/prayer_screen.dart';
import 'views/more_screen.dart';

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
