import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isGuest = false;
  String? _userId;
  String? _userName;
  String? _userEmail;

  bool get isAuthenticated => _isAuthenticated;
  bool get isGuest => _isGuest;
  String? get userId => _userId;
  String? get userName => _userName;
  String? get userEmail => _userEmail;

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // TODO: Implement API call to sign up
      // For now, we'll just simulate a successful signup
      _isAuthenticated = true;
      _isGuest = false;
      _userId = 'temp_user_id';
      _userName = name;
      _userEmail = email;

      // Save auth state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isAuthenticated', true);
      await prefs.setBool('isGuest', false);
      await prefs.setString('userId', _userId!);
      await prefs.setString('userName', _userName!);
      await prefs.setString('userEmail', _userEmail!);

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // TODO: Implement API call to sign in
      // For now, we'll just simulate a successful signin
      _isAuthenticated = true;
      _isGuest = false;
      _userId = 'temp_user_id';
      _userName = 'Test User';
      _userEmail = email;

      // Save auth state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isAuthenticated', true);
      await prefs.setBool('isGuest', false);
      await prefs.setString('userId', _userId!);
      await prefs.setString('userName', _userName!);
      await prefs.setString('userEmail', _userEmail!);

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signInAsGuest() async {
    _isAuthenticated = true;
    _isGuest = true;
    _userId = 'guest_${DateTime.now().millisecondsSinceEpoch}';
    _userName = 'Guest';
    _userEmail = null;

    // Save auth state
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAuthenticated', true);
    await prefs.setBool('isGuest', true);
    await prefs.setString('userId', _userId!);
    await prefs.setString('userName', _userName!);

    notifyListeners();
  }

  Future<void> signOut() async {
    _isAuthenticated = false;
    _isGuest = false;
    _userId = null;
    _userName = null;
    _userEmail = null;

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
    _userName = prefs.getString('userName');
    _userEmail = prefs.getString('userEmail');

    notifyListeners();
  }
}
