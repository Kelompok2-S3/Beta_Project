import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  static const String _usersKey = 'users_data';
  static const String _currentUserKey = 'current_user';

  // Singleton pattern
  static final AuthRepository _instance = AuthRepository._internal();
  factory AuthRepository() => _instance;
  AuthRepository._internal();

  Future<bool> register(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final usersString = prefs.getString(_usersKey);
    Map<String, dynamic> users = {};
    
    if (usersString != null) {
      users = jsonDecode(usersString);
    }

    if (users.containsKey(email)) {
      return false; // User already exists
    }

    users[email] = password; // In a real app, hash this password!
    await prefs.setString(_usersKey, jsonEncode(users));
    await prefs.setString(_currentUserKey, email); // Auto login after register
    return true;
  }

  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final usersString = prefs.getString(_usersKey);
    
    if (usersString == null) return false;

    final users = jsonDecode(usersString);
    if (users.containsKey(email) && users[email] == password) {
      await prefs.setString(_currentUserKey, email);
      return true;
    }

    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentUserKey);
  }

  Future<String?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_currentUserKey);
  }
}
