import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  static const String baseUrl =
      'http://localhost:8000'; // Change this to your backend URL
  bool _isAuthenticated = false;
  bool _isGuest = false;
  String? _userId;
  String? _firstName;
  String? _lastName;
  String? _userEmail;
  String? _token;

  bool get isAuthenticated => _isAuthenticated;
  bool get isGuest => _isGuest;
  String? get userId => _userId;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get userEmail => _userEmail;
  String? get fullName =>
      _firstName != null && _lastName != null ? '$_firstName $_lastName' : null;

  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'first_name': firstName,
          'last_name': lastName,
          'password': password,
          'role': 'member',
        }),
      );

      if (response.statusCode == 201) {
        final userData = jsonDecode(response.body);
        _isAuthenticated = true;
        _isGuest = false;
        _userId = userData['id'].toString();
        _firstName = userData['first_name'];
        _lastName = userData['last_name'];
        _userEmail = userData['email'];

        // Save auth state
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isAuthenticated', true);
        await prefs.setBool('isGuest', false);
        await prefs.setString('userId', _userId!);
        await prefs.setString('firstName', _firstName!);
        await prefs.setString('lastName', _lastName!);
        await prefs.setString('userEmail', _userEmail!);

        notifyListeners();
      } else {
        final error = jsonDecode(response.body);
        throw error['detail'] ?? 'Failed to sign up';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // TODO: Implement proper authentication endpoint
      // For now, we'll use the user lookup endpoint
      final response = await http.get(
        Uri.parse('$baseUrl/users/'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final users = jsonDecode(response.body) as List;
        final user = users.firstWhere(
          (u) => u['email'] == email,
          orElse: () => throw 'Invalid email or password',
        );

        // TODO: Implement proper password verification
        if (user['hashed_password'] != password) {
          throw 'Invalid email or password';
        }

        _isAuthenticated = true;
        _isGuest = false;
        _userId = user['id'].toString();
        _firstName = user['first_name'];
        _lastName = user['last_name'];
        _userEmail = user['email'];

        // Save auth state
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isAuthenticated', true);
        await prefs.setBool('isGuest', false);
        await prefs.setString('userId', _userId!);
        await prefs.setString('firstName', _firstName!);
        await prefs.setString('lastName', _lastName!);
        await prefs.setString('userEmail', _userEmail!);

        notifyListeners();
      } else {
        throw 'Failed to sign in';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signInAsGuest() async {
    _isAuthenticated = true;
    _isGuest = true;
    _userId = 'guest_${DateTime.now().millisecondsSinceEpoch}';
    _firstName = 'Guest';
    _lastName = null;
    _userEmail = null;

    // Save auth state
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAuthenticated', true);
    await prefs.setBool('isGuest', true);
    await prefs.setString('userId', _userId!);
    await prefs.setString('firstName', _firstName!);

    notifyListeners();
  }

  Future<void> signOut() async {
    _isAuthenticated = false;
    _isGuest = false;
    _userId = null;
    _firstName = null;
    _lastName = null;
    _userEmail = null;
    _token = null;

    // Clear auth state
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    notifyListeners();
  }

  Future<void> checkAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    _isAuthenticated = prefs.getBool('isAuthenticated') ?? false;
    _isGuest = prefs.getBool('isGuest') ?? false;
    _userId = prefs.getString('userId');
    _firstName = prefs.getString('firstName');
    _lastName = prefs.getString('lastName');
    _userEmail = prefs.getString('userEmail');

    notifyListeners();
  }
}
