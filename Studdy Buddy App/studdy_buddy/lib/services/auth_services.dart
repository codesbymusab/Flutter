import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studdy_buddy/database/app_database.dart';
import 'package:studdy_buddy/models/user_model.dart';

class AuthServices extends ChangeNotifier {
  final String _statusKey = 'Status';
  final String _userKey = 'UserId';
  User? currentUser;
  static SharedPreferences? _instance;
  AppDatabase db = AppDatabase.instance;

  static Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
  }

  Future<bool> isUserLoggedIn() async {
    if (_instance == null) await init();
    return _instance!.getBool(_statusKey) ?? false;
  }

  Future<void> registerUser(User newUser) async {
    await db.insertUser(newUser.toJson());
  }

  Future<User?> loginUser(String email, String password) async {
    final database = await db.database;
    print(await database.query(tableUsers));
    final result = await db.readUser(email, password);
    if (result.isNotEmpty) {
      currentUser = User.fromJson(result.first);
      if (_instance == null) await init();
      _instance!.setBool(_statusKey, true);
      _instance!.setString(_userKey, currentUser!.id);
      return currentUser!;
    } else {
      return null;
    }
  }

  Future<User?> get user async {
    if (currentUser == null && await isUserLoggedIn()) {
      final result = await db.readCurrentUser(_instance!.getString(_userKey)!);
      if (result.isNotEmpty) {
        currentUser = User.fromJson(result.first);
      }
    }
    return currentUser;
  }

  Future<void> signOutUser() async {
    _instance ?? await init();
    _instance!.remove(_statusKey);
    _instance!.remove(_userKey);
  }
}
